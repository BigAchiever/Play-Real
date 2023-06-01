import 'package:flutter/material.dart';
import 'package:play_real/dialog/widgets/player_buttons.dart';

import '../../config/theme/themedata.dart';

class PlayerCountSelectionWidget extends StatefulWidget {
  final ValueChanged<int> onPlayerCountChanged;

  const PlayerCountSelectionWidget(
      {super.key, required this.onPlayerCountChanged});
  @override
  _PlayerCountSelectionWidgetState createState() =>
      _PlayerCountSelectionWidgetState();
}

class _PlayerCountSelectionWidgetState
    extends State<PlayerCountSelectionWidget> {
  int numberOfPlayers = 2;

  void onPlayerCountChanged(int count) {
    setState(() {
      numberOfPlayers = count;
    });
    widget.onPlayerCountChanged(count); // Call the callback function
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Players :',
          style: TextStyle(
            fontSize: 18,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          runSpacing: 8,
          children: [
            PlayerCountButton(
              count: 2,
              isSelected: numberOfPlayers == 2,
              onChanged: onPlayerCountChanged,
            ),
            PlayerCountButton(
              count: 3,
              isSelected: numberOfPlayers == 3,
              onChanged: onPlayerCountChanged,
            ),
            PlayerCountButton(
              count: 4,
              isSelected: numberOfPlayers == 4,
              onChanged: onPlayerCountChanged,
            ),
            PlayerCountButton(
              count: 5,
              isSelected: numberOfPlayers == 5,
              onChanged: onPlayerCountChanged,
            ),
            PlayerCountButton(
              count: 6,
              isSelected: numberOfPlayers == 6,
              onChanged: onPlayerCountChanged,
            ),
            PlayerCountButton(
              count: 7,
              isSelected: numberOfPlayers == 7,
              onChanged: onPlayerCountChanged,
            ),
            PlayerCountButton(
              count: 8,
              isSelected: numberOfPlayers == 8,
              onChanged: onPlayerCountChanged,
            ),
          ],
        ),
      ],
    );
  }
}
