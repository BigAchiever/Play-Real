import 'package:flutter/material.dart';

import '../../../config/theme/themedata.dart';
import '../services/nanoid.dart';
import 'button.dart';
import 'teamcode_button.dart';

class TeamCodeWidget extends StatefulWidget {
  final void Function(String teamCode) onTeamCodeGenerated;
  const TeamCodeWidget({
    Key? key,
    required this.onTeamCodeGenerated,
  }) : super(key: key);

  @override
  _TeamCodeWidgetState createState() => _TeamCodeWidgetState();
}

class _TeamCodeWidgetState extends State<TeamCodeWidget> {
  String? teamCode;

  void teamCodeFunction() {
    setState(() {
      teamCode = generateTeamCode();
    });
    widget.onTeamCodeGenerated(teamCode!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tap to Generate TeamCode:',
          style: TextStyle(
            fontSize: 16,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TeamcodeButton(
              onPressed: teamCodeFunction,
            ),
            SizedBox(width: 16),
            if (teamCode != null)
              GeneratedTeamCodeButton(
                teamCode: teamCode!,
              ),
          ],
        ),
      ],
    );
  }
}
