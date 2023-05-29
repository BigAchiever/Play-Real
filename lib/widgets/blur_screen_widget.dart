import 'package:flutter/material.dart';

import '../config/theme/themedata.dart';
import '../screens/home.dart';

Widget blurScreenWidget(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Container(
    height: size.height,
    width: size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          StartingScreenState.lightmodedarkmode
              ? lightGradientColor1
              : gradientColor1,

          // the whole screen will be of same gradient
          if (StartingScreenState.lightmodedarkmode == true)
            StartingScreenState.lightmodedarkmode
                ? lightGradientColor1
                : gradientColor1,

          // else the whole screen will have two gradient colors
          if (StartingScreenState.lightmodedarkmode == false)
            StartingScreenState.lightmodedarkmode
                ? lightGradientColor2
                : gradientColor2,
        ],
      ),
    ),
  );
}
