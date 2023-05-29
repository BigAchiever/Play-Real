import 'package:flutter/material.dart';

import '../config/theme/themedata.dart';
import '../screens/home.dart';

class FailedButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const FailedButton({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 50,
      child: FloatingActionButton(
        heroTag: "btn2",
        onPressed: isEnabled ? onPressed : null,
        backgroundColor: StartingScreenState.lightmodedarkmode
            ? lightFailedColor
            : failedColor,
        foregroundColor: buttonForegroundColor,
        focusColor: commonGreyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed 💀',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "GameFont",
                    color: StartingScreenState.lightmodedarkmode
                        ? lightbuttonForegroundColor
                        : buttonForegroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '(-5 Steps)',
                  style: TextStyle(
                    fontSize: 12,
                    color: StartingScreenState.lightmodedarkmode
                        ? lightbuttonForegroundColor
                        : buttonForegroundColor,
                    fontFamily: "GameFont",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
