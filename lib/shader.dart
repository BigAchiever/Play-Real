import 'package:flutter/material.dart';

class CustomTextPainter extends CustomPainter {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const CustomTextPainter({
    required this.text,
    this.fontSize = 60,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();

    final offsetX = (size.width - textPainter.width) / 2;
    final offsetY = (size.height - textPainter.height) / 2;

    final path = Path()
      ..moveTo(offsetX, offsetY)
      ..lineTo(offsetX + textPainter.width, offsetY)
      ..lineTo(
          offsetX + textPainter.width - 10, offsetY + textPainter.height - 10)
      ..lineTo(offsetX + 10, offsetY + textPainter.height - 10)
      ..close();

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.drawPath(path, paint);
    canvas.save();
    canvas.clipPath(path);
    textPainter.paint(canvas, Offset(offsetX, offsetY));
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomTextPainter oldDelegate) {
    return text != oldDelegate.text ||
        fontSize != oldDelegate.fontSize ||
        fontWeight != oldDelegate.fontWeight ||
        color != oldDelegate.color;
  }
}
