import 'package:flutter/material.dart';
import 'package:play_real/screens/home.dart';

void showError(
  BuildContext context,
  String content,
) {
  Size size = MediaQuery.of(context).size;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Column(
      children: [
        Container(
          height: 70,
          width: size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.transparent,
              ),
            ],
            border: Border.all(color: Colors.black, width: 2),
            color: StartingScreenState.lightmodedarkmode
                ? Colors.deepOrange[400]
                : Colors.deepOrange[900],
            borderRadius: BorderRadius.circular(
              35,
            ),
          ),
          child: Center(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 22,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.fixed,
    elevation: 0,
  ));
}
