// File: /lib/widgets/nav_button.dart
import 'dart:developer';
import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  final String label;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  const NavButton({
    super.key,
    required this.label,
    required this.description,
    required this.icon,
    required this.onPressed,
  });

  @override
  _NavButtonState createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) {
      _controller.reverse();
      widget.onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 반응형 레이아웃에서 크기 설정
        double buttonWidth = constraints.maxWidth > 500
            ? constraints.maxWidth * 0.6
            : constraints.maxWidth * 0.9;
        double iconSize = constraints.maxWidth > 500 ? 30 : 24;
        double labelFontSize = constraints.maxWidth > 500 ? 18 : 16;
        double descriptionFontSize = constraints.maxWidth > 500 ? 14 : 12;

        // 반응형 SizedBox의 너비 설정
        double sizedBoxWidth =
            constraints.maxWidth > 800 ? constraints.maxWidth / 7 : 50;

        return ScaleTransition(
          scale: _animation,
          child: Container(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: _handleTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: sizedBoxWidth, // 반응형 SizedBox
                  ),
                  Container(
                    child:
                        Icon(widget.icon, color: Colors.blue, size: iconSize),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: labelFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: descriptionFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
