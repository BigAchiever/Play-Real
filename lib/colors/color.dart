import 'package:flutter/material.dart';

Color getPlayerColor(int index) {
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
    Colors.pink,
  ];
  return colors[index % colors.length];
}
