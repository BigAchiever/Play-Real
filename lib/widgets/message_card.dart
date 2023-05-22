import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double borderRadius;

  final Color shadowColor;
  final Color borderColor;
  final double borderWidth;

  const ElevatedContainer({
    Key? key,
    required this.child,
    this.elevation = 8.0,
    this.borderRadius = 8.0,
    this.shadowColor = const Color.fromARGB(255, 31, 27, 55),
    this.borderColor = const Color.fromARGB(255, 255, 145, 0),
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: shadowColor.withOpacity(0.4),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.8),
            ),
          ],
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}