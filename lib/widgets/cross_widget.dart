import 'package:flutter/material.dart';

Widget crossWidget(context, top, right) {
  return Positioned(
    top: top,
    right: right,
    child: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.cancel,
        size: 32,
        color: Colors.white,
      ),
    ),
  );
}
