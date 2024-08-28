// File: /lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/utils.dart';
import 'package:go_router/go_router.dart';
import '../widgets/nav_button.dart';
import '../widgets/login_card.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  String _currentDate = getFormattedCurrentDate();
  String _currentTime = getFormattedCurrentTime();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
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
                LoginCard(
                    usernameController: _usernameController,
                    passwordController: _passwordController),
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
          );
        },
      ),
    );
  }
}
