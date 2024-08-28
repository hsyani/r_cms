// File: /lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          // 최소 크기 설정
          if (constraints.maxWidth < 800) {
            return SizedBox(
              width: 800,
              height: constraints.maxHeight,
              child: HomeScreen(),
            );
          }
          return HomeScreen();
        },
      ),
    );
  }
}
