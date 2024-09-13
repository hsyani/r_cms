// File: /lib/screens/manager_screen.dart

import 'package:flutter/material.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manager Page')),
      body: const Center(
        child: Text('This is the Manager Page'),
      ),
    );
  }
}
