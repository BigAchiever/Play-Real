import 'package:flutter/material.dart';
import 'package:play_real/colors/theme/themedata.dart';

class PlayerCountButton extends StatelessWidget {
  final int count;
  final bool isSelected;
  final ValueChanged<int> onChanged;

  const PlayerCountButton({
    Key? key,
    required this.count,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 50,
      child: ElevatedButton(
        onPressed: () => onChanged(count),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? selectedColor : unselectedButtonColor,
          shape: const CircleBorder(),
        ),
        child: Text(
          count.toString().split('.').last,
          style:  TextStyle(
            fontSize: 18,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
