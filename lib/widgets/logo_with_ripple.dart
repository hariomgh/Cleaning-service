import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LogoWithRipple extends StatelessWidget {
  const LogoWithRipple({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer ripple circle
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.lightGray.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        // Middle ripple circle
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.lightGray.withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
        // Inner white circle
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          child: Center(
            child: CustomPaint(
              size: const Size(60, 60),
              painter: InterlockingRingsPainter(),
            ),
          ),
        ),
      ],
    );
  }
}

class InterlockingRingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryGreen
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Draw two interlocking rings (C shapes)
    // Left C
    canvas.drawArc(
      Rect.fromCircle(center: center - Offset(radius * 0.3, 0), radius: radius),
      -1.5,
      2.5,
      false,
      paint..strokeWidth = 8..style = PaintingStyle.stroke,
    );

    // Right C (interlocking)
    canvas.drawArc(
      Rect.fromCircle(center: center + Offset(radius * 0.3, 0), radius: radius),
      1.5,
      2.5,
      false,
      paint..strokeWidth = 8..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



