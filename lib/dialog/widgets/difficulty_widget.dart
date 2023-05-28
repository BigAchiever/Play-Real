import 'package:flutter/material.dart';

import '../../config/theme/themedata.dart';
import 'difficult_button.dart';

class DifficultySelectionWidget extends StatefulWidget {
  final Function(DifficultyLevel) onDifficultyChanged;

  const DifficultySelectionWidget(
      {super.key, required this.onDifficultyChanged});
  @override
  _DifficultySelectionWidgetState createState() =>
      _DifficultySelectionWidgetState();
}

class _DifficultySelectionWidgetState extends State<DifficultySelectionWidget> {
  DifficultyLevel selectedDifficulty = DifficultyLevel.Default;

  void _onDifficultyChanged(DifficultyLevel difficulty) {
    setState(() {
      selectedDifficulty = difficulty;
    });
    widget.onDifficultyChanged(difficulty); // callback function
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficulty Level:',
          style: TextStyle(
            fontSize: 16,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          runSpacing: 8,
          children: DifficultyLevel.values.map((level) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: DifficultyButton(
                level: level,
                isSelected: selectedDifficulty == level,
                onChanged: _onDifficultyChanged,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
