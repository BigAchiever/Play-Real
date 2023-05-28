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
        radius: 18,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.close,
          size: 20,
          color: Colors.red,
        ),
      ),
    ),
  );
}
