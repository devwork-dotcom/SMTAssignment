import 'dart:math';

import 'package:flutter/material.dart';

class DotCircularProgressIndicator extends StatefulWidget {
  final double size;
  final Color dotColor;
  final int numberOfDots;
  final Duration duration;
  final double maxDotRadius;
  final double minDotRadius;
  final double startAngle;

  const DotCircularProgressIndicator({
    super.key,
    this.size = 40.0,
    this.dotColor = Colors.blue,
    this.numberOfDots = 8,
    this.duration = const Duration(milliseconds: 2200),
    this.maxDotRadius = 5.0,
    this.minDotRadius = 2.0,
    this.startAngle = -90.0,
  });

  @override
  State<DotCircularProgressIndicator> createState() => _DotCircularProgressIndicatorState();
}

class _DotCircularProgressIndicatorState extends State<DotCircularProgressIndicator>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: DotCircularProgressPainter(
              animationValue: _animationController.value,
              dotColor: widget.dotColor,
              numberOfDots: widget.numberOfDots,
              maxDotRadius: widget.maxDotRadius,
              minDotRadius: widget.minDotRadius,
              startAngle: widget.startAngle,
            ),
          );
        },
      ),
    );
  }
}

class DotCircularProgressPainter extends CustomPainter {
  final double animationValue;
  final Color dotColor;
  final int numberOfDots;
  final double maxDotRadius;
  final double minDotRadius;
  final double startAngle;

  // Constructor e startAngle parameter add koro
  DotCircularProgressPainter({
    required this.animationValue,
    required this.dotColor,
    required this.numberOfDots,
    this.maxDotRadius = 5.0,
    this.minDotRadius = 2.0,
    this.startAngle = -90.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - maxDotRadius;

    // Convert degrees to radians and adjust for Flutter's coordinate system
    final startAngleRadians = startAngle * pi / 180;

    for (int i = 0; i < numberOfDots; i++) {
      // Start from top (90 degrees) and move clockwise
      final angle = startAngleRadians + 2 * pi * (i / numberOfDots) + 2 * pi * animationValue;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      // First dot choto, then gradually boro hobe
      final sizeProgress = (i / numberOfDots + animationValue) % 1.0;
      final dotRadius = minDotRadius + (maxDotRadius - minDotRadius) * sizeProgress;

      // Alpha value - boro dot bright, choto dot fade
      final alpha = sizeProgress;
      final color = dotColor.withOpacity(alpha);

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DotCircularProgressPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        dotColor != oldDelegate.dotColor ||
        numberOfDots != oldDelegate.numberOfDots ||
        maxDotRadius != oldDelegate.maxDotRadius ||
        minDotRadius != oldDelegate.minDotRadius ||
        startAngle != oldDelegate.startAngle;
  }
}