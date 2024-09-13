// File: /lib/screens/home_scren.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/login_card.dart';
import '../services/login_provider.dart'; // 로그인 상태 관리
import 'manager_home_screen.dart'; // Manager용 화면
import '../widgets/nav_button.dart';
import '../utils/utils.dart'; // 날짜 및 시간 포맷 관련 유틸

class InitScreen extends ConsumerStatefulWidget {
  const InitScreen({super.key});

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {
  String _currentDate = getFormattedCurrentDate();
  String _currentTime = getFormattedCurrentTime();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Timer? _timer;
  bool _isLoading = false; // 로그인 시도 중인지 확인하는 플래그

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // 화면의 날짜 및 시간 업데이트를 위한 타이머
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentDate = getFormattedCurrentDate();
        _currentTime = getFormattedCurrentTime();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true; // 로그인 시도 중
    });

    try {
      // 로그인 시도
      await ref.read(loginStateProvider.notifier).login(_usernameController.text, _passwordController.text);

      final loginState = ref.read(loginStateProvider);

      if (loginState['isLoggedIn']) {
        // 로그인 성공 시 역할에 따라 다른 화면으로 이동
        if (loginState['role'] == 'worker') {
          context.push('/workerhome'); // Worker 화면으로 이동
        } else if (loginState['role'] == 'manager') {
          context.push('/manager'); // Manager 화면으로 이동
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('로그인 실패. 아이디나 비밀번호를 확인하세요.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // 로그인 시도 종료
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(loginStateProvider.notifier).resetLogoutTimer(); // 사용자가 클릭할 때마다 타이머 리셋
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;

            // 반응형으로 패딩 설정
            double horizontalPadding = maxWidth > 800 ? 80.0 : 20.0;
            double verticalPadding = 40.0;

            double dateFontSize = maxWidth > 600 ? 24 : 18;
            double timeFontSize = maxWidth > 600 ? 64 : 48;

            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scist_logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _currentDate,
                    style: TextStyle(
                      fontSize: dateFontSize,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _currentTime,
                    style: TextStyle(
                      fontSize: timeFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _isLoading
                      ? const CircularProgressIndicator() // 로딩 중일 때 로딩 표시
                      : LoginCard(
                          usernameController: _usernameController,
                          passwordController: _passwordController,
                          onLoginPressed: _handleLogin, // 로그인 버튼 클릭 시 로그인 처리
                        ),
                  const SizedBox(height: 20),
                  NavButton(
                      label: 'MSDS 열람',
                      description: '등록된 MSDS 확인',
                      icon: Icons.warning_amber_outlined,
                      onPressed: () {
                        // MSDS 화면 전환 로직
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
