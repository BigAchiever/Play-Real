import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';
import 'package:provider/provider.dart';

import '../appwrite/auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? uid, username;

  @override
  void initState() {
    super.initState();
    final AuthAPI appwrite = context.read<AuthAPI>();
    uid = appwrite.userid;
    username = appwrite.currentUser.name;
  }

  signOut() {
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      backgroundColor: StartingScreenState.lightmodedarkmode
          ? lightStartGameDialogColor
          : DialogBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: StartingScreenState.lightmodedarkmode
                ? lightBorderColor
                : borderColor,
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
                  color: StartingScreenState.lightmodedarkmode
                      ? lightbuttonForegroundColor
                      : textColor,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // player avatar here
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/8186664?v=4',
              ),
              radius: 50.0,
            ),
            const SizedBox(height: 40),
            Text(
              'Player Name: ',
              style: TextStyle(
                fontSize: 24,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: StartingScreenState.lightmodedarkmode
                    ? lightbuttonForegroundColor
                    : textColor,
              ),
            ),

            Text(
              username!,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: commonGreyColor,
              ),
            ),

            const SizedBox(height: 40),
            Text(
              'UID:',
              style: TextStyle(
                fontSize: 24,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: StartingScreenState.lightmodedarkmode
                    ? lightbuttonForegroundColor
                    : textColor,
              ),
            ),

            Text(
              uid!,
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
                    backgroundColor: StartingScreenState.lightmodedarkmode
                        ? lightCommonButton1
                        : CommonButton2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500,
                      color: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : buttonForegroundColor,
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
