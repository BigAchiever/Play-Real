import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';

class HomeScreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const HomeScreenButton({
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          backgroundColor: StartingScreenState.lightmodedarkmode
              ? lightCommonButton1
              : CommonButton,
          foregroundColor: StartingScreenState.lightmodedarkmode
              ? lightbuttonForegroundColor
              : buttonForegroundColor,
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
