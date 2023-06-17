import 'package:flutter/material.dart';
import 'package:play_real/screens/home.dart';

import '../config/theme/themedata.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Widget? heroTag;

  const CustomIconButton({
    required this.onPressed,
    required this.child,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 8,
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        elevation: 0,
        backgroundColor: StartingScreenState.lightmodedarkmode
            ? lightCommonButton2
            : CommonButton2,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: child,
      ),
    );
  }
}
