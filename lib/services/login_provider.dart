// File: /lib/services/login_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 로그인 상태 관리 provider
final loginStateProvider = StateNotifierProvider<LoginNotifier, Map>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<Map> {
  String? _role; // 사용자의 역할 저장 (worker 또는 manager)
  Timer? _logoutTimer;
  String? _accessToken;

  LoginNotifier() : super({'isLoggedIn': false, 'role': null});

  // 로그인 요청
  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _role = data['role']; // 서버에서 받은 role 저장
      _accessToken = data['access']; // JWT access token 저장
      state = {'isLoggedIn': true, 'role': _role}; // 로그인 성공 상태와 역할 저장
      _startAutoLogout(); // 자동 로그아웃 타이머 시작
    } else {
      state = {'isLoggedIn': false, 'role': null}; // 로그인 실패 상태 저장
      throw Exception('로그인 실패: ${response.statusCode}');
    }
  }

  // 자동 로그아웃 타이머 시작
  void _startAutoLogout() {
    _logoutTimer?.cancel(); // 기존 타이머 취소
    _logoutTimer = Timer(const Duration(minutes: 1), () {
      logout(); // 1분 뒤 자동 로그아웃
    });
  }

  // 로그아웃 처리
  void logout() {
    _accessToken = null;
    state = {'isLoggedIn': false, 'role': null}; // 로그아웃 시 상태 초기화
    _logoutTimer?.cancel(); // 타이머 종료
  }

  // 사용자가 활동할 때 로그아웃 타이머 리셋
  void resetLogoutTimer() {
    if (state != null) {
      _startAutoLogout(); // 로그인이 되어 있을 때만 타이머 리셋
    }
  }
}
