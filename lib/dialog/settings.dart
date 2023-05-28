import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';
import 'package:play_real/widgets/profile_text_field.dart';
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
  static TextEditingController bioTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final AuthAPI appwrite = context.read<AuthAPI>();
    uid = appwrite.userid;
    username = appwrite.username;
    appwrite.getUserPreferences().then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          bioTextController.text = value.data['bio'];
        });
      }
    });
  }

  signOut() {
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.signOut();
  }

  void savePreferences(String bio) {
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.updatePreferences(bio: bio);
    const snackbar = SnackBar(content: Text('Preferences updated!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
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
                'Profile',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/8186664?v=4',
                  ),
                  radius: 40.0,
                ),
                Column(
                  children: [
                    Text(
                      username ?? 'Player 1',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "GameFont",
                        fontWeight: FontWeight.w500,
                        color: StartingScreenState.lightmodedarkmode
                            ? lightbuttonForegroundColor
                            : textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      uid ?? 'Not authenticated',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "GameFont",
                        fontWeight: FontWeight.w500,
                        color: StartingScreenState.lightmodedarkmode
                            ? lightbuttonForegroundColor
                            : textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
                width: 250,
                child: buildTextField3(
                    context, savePreferences, bioTextController)),

            const SizedBox(height: 10),
            // save button
          ],
        ),
      ),
    );
  }
}
