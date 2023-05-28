import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme/themedata.dart';
import '../../provvider/player_age_provider.dart';


class PlayerAgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerAgeProvider>(
      builder: (context, playerAgeProvider, _) {
        return Container(
          height: 60,
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "PR AGE",
                style: TextStyle(
                  fontSize: 18,
                  color: commonGreyColor,
                  fontFamily: "Gamefont",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                playerAgeProvider.formatDuration(playerAgeProvider.playerAge),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: "Gamefont",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
