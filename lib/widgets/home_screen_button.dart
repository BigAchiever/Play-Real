import 'package:flutter/material.dart';

class HomeScreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;

  const HomeScreenButton({
    required this.onPressed,
    required this.child,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Colors.black,
              width: 3,
            ),
          ),
          elevation: 0,
          visualDensity: VisualDensity.standard,
        ),
        child: child,
      ),
    );
  }
}
