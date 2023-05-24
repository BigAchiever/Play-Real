import 'package:flutter/material.dart';
import 'package:play_real/colors/theme/themedata.dart';

class SettingsScreen extends StatelessWidget {
  final String avatarImageUrl;
  final String playerName;
  final String gameDetails;

  const SettingsScreen({
    super.key,
    required this.avatarImageUrl,
    required this.playerName,
    required this.gameDetails,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      backgroundColor: DialogBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 34,
                  fontFamily: "GameFont",
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // player avatar here
            CircleAvatar(
              backgroundImage: NetworkImage(avatarImageUrl),
              radius: 50.0,
            ),
            const SizedBox(height: 40),
            Text(
              'Player Name: ',
              style: TextStyle(
                fontSize: 24,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),

            Text(
              playerName,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: commonGreyColor,
              ),
            ),

            const SizedBox(height: 40),
            Text(
              'Achievement:',
              style: TextStyle(
                fontSize: 24,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),

            Text(
              gameDetails,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: commonGreyColor,
              ),
            ),
            const SizedBox(height: 60),
            Center(
              child: SizedBox(
                width: size.width / 2,
                height: size.height / 15,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CommonButton2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
