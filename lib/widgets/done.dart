import 'package:flutter/material.dart';

import '../config/theme/themedata.dart';
import '../screens/home.dart';

class DoneButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const DoneButton({
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
        heroTag: "btn1",
        onPressed: isEnabled ? onPressed : null,
        backgroundColor: StartingScreenState.lightmodedarkmode
            ? lightSuccessColor
            : successColor,
        foregroundColor: buttonForegroundColor,
        focusColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Done 😎',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "GameFont",
                color: StartingScreenState.lightmodedarkmode
                    ? lightbuttonForegroundColor
                    : buttonForegroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
