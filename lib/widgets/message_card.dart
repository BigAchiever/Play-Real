import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double borderRadius;

  final double borderWidth;

  const ElevatedContainer({
    Key? key,
    required this.child,
    this.elevation = 8.0,
    this.borderRadius = 8.0,
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: messageBoxColor.withOpacity(0.4),
          boxShadow: [
            BoxShadow(
              color: StartingScreenState.lightmodedarkmode
                  ? lightMessageBoxColor.withOpacity(0.8)
                  : messageBoxColor.withOpacity(0.8),
            ),
          ],
          border: Border.all(
            color: StartingScreenState.lightmodedarkmode
                ? lightButtonBorderColor
                : borderColor,
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}
