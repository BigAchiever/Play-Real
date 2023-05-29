import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme/themedata.dart';
import '../../provider/player_age_provider.dart';

class PlayerAgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<PlayerAgeProvider>(
      builder: (context, playerAgeProvider, _) {
        return Container(
          height: size.height * 0.07,
          width: size.width * 0.2,
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
