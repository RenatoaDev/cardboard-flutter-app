import 'package:flutter/material.dart';

class CustomStackBackground extends StatelessWidget {
  final List<Widget> children;

  const CustomStackBackground({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1e4d61),
                  Color(0xFF2c958f),
                ],
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
