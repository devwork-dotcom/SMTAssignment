import 'dart:math';

import 'package:flutter/material.dart';

class SimpleDotProgressIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const SimpleDotProgressIndicator({
    super.key,
    this.size = 40.0,
    this.color = Colors.blue,
  });

  @override
  State<SimpleDotProgressIndicator> createState() => _SimpleDotProgressIndicatorState();
}

class _SimpleDotProgressIndicatorState extends State<SimpleDotProgressIndicator>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: CustomPaint(
              painter: SimpleDotPainter(dotColor: widget.color),
            ),
          );
        },
      ),
    );
  }
}

class SimpleDotPainter extends CustomPainter {
  final Color dotColor;

  SimpleDotPainter({required this.dotColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final dotCount = 8;
    final dotRadius = radius / 6;

    for (int i = 0; i < dotCount; i++) {
      final angle = 2 * pi * (i / dotCount);
      final x = center.dx + (radius - dotRadius) * cos(angle);
      final y = center.dy + (radius - dotRadius) * sin(angle);

      final opacity = 1.0 - (i / dotCount);
      final paint = Paint()
        ..color = dotColor.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SimpleDotPainter oldDelegate) {
    return dotColor != oldDelegate.dotColor;
  }
}