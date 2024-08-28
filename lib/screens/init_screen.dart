// File: /lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:r_cms_v_3_0/screens/home_screen.dart';
import 'package:r_cms_v_3_0/widgets/login_card.dart';
import 'dart:async';
import '../utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:r_cms_v_3_0/widgets/nav_button.dart';

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

            double dateFontSize = maxWidth > 600 ? 24 : 18;
            double timeFontSize = maxWidth > 600 ? 64 : 48;

            return Column(
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: maxWidth > 600 ? 40.0 : 20.0),
                  child: Column(
                    children: [
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
}
