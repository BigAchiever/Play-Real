import 'package:flutter/material.dart';
import 'package:play_real/colors/theme/themedata.dart';

class GridSizeButton extends StatelessWidget {
  final int size;
  final bool isSelected;
  final ValueChanged<int> onChanged;

  const GridSizeButton({
    Key? key,
    required this.size,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 40,
      child: ElevatedButton(
        onPressed: () => onChanged(size),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          backgroundColor: isSelected ? selectedColor : unselectedButtonColor,
          shape: const StadiumBorder(),
        ),
        child: Text(
          '${size}x$size',
          style: TextStyle(
            fontSize: 18,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
