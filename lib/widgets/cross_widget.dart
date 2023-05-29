import 'package:flutter/material.dart';

Widget crossWidget(context, top, right) {
  return Positioned(
    top: top,
    right: right,
    child: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.white,
        child: Icon(
          shadows: [BoxShadow(color: Colors.red, blurRadius: 4)],
          Icons.close,
          size: 18,
          color: Colors.red,
        ),
      ),
    ),
  );
}
