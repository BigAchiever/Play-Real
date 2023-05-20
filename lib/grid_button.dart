import 'package:flutter/material.dart';

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
          padding: EdgeInsets.all(8),
          primary: isSelected ? Colors.blue : Colors.grey,
          shape: const StadiumBorder(),
        ),
        child: Text(
          '${size}x$size',
          style: const TextStyle(
            fontSize: 18,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
