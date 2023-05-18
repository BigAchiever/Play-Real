import 'package:flutter/material.dart';

enum DifficultyLevel {
  // ignore: constant_identifier_names
  Default,
  kids,
  medium,
  sarcastic,
}

class DifficultyButton extends StatelessWidget {
  final DifficultyLevel level;
  final bool isSelected;
  final ValueChanged<DifficultyLevel> onChanged;

  const DifficultyButton({
    Key? key,
    required this.level,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onChanged(level),
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.blue : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        level.toString().split('.').last,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: "GameFont",
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
