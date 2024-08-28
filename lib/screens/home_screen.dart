// File: /lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/utils.dart';
import 'login_screen.dart';
import '../widgets/nav_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentDate = getFormattedCurrentDate();
  String _currentTime = getFormattedCurrentTime();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;

            // 반응형으로 폰트 사이즈 조정
            double dateFontSize = maxWidth > 600 ? 24 : 18;
            double timeFontSize = maxWidth > 600 ? 64 : 48;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: maxWidth > 600 ? 40.0 : 20.0),
                  child: Column(
                    children: [
                      NavButton(
                        label: '로그인',
                        description: '아이디/패스워드 입력 및 바코드 로그인',
                        icon: Icons.login,
                        onPressed: () {
                          _showLoginDialog(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      NavButton(
                        label: '일일 안전 점검',
                        description: '간편한 안전점검 일지 작성',
                        icon: Icons.check_circle_outline,
                        onPressed: () {
                          // 화면 전환 로직
                        },
                      ),
                      const SizedBox(height: 20),
                      NavButton(
                        label: 'MSDS 열람',
                        description: '등록된 MSDS 확인',
                        icon: Icons.warning_amber_outlined,
                        onPressed: () {
                          // 화면 전환 로직
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Center(
            child: Text(
              '로그인',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '아이디와 비밀번호를 입력해주시거나\n바코드를 스캔하세요',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: '아이디',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: '패스워드',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.qr_code_scanner),
                  labelText: '바코드입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '취소',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 로그인 버튼 로직
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
