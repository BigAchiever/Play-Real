import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/dialog/widgets/player_age.dart';
import 'package:play_real/screens/home.dart';
import 'package:play_real/widgets/cross_widget.dart';
import 'package:play_real/widgets/error_widget.dart';
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
    showError(context, 'Updated your bio!');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        child: Stack(children: [
          Column(
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
                width: 260,
                child: buildTextField3(
                    context, savePreferences, bioTextController),
              ),
              const SizedBox(height: 20),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "FRIENDS",
                              style: TextStyle(
                                fontSize: 18,
                                color: commonGreyColor,
                                fontFamily: "Gamefont",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: "Gamefont",
                              ),
                            ),
                          ]),
                    ),
                    VerticalDivider(
                      color: Colors.yellow,
                      thickness: 1,
                    ),
                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.15,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "WINS",
                              style: TextStyle(
                                fontSize: 18,
                                color: commonGreyColor,
                                fontFamily: "Gamefont",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: "Gamefont",
                              ),
                            ),
                          ]),
                    ),
                    VerticalDivider(
                      color: Colors.yellow,
                      thickness: 1,
                    ),
                    PlayerAgeWidget(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          crossWidget(context, 0.0, 0.0)
        ]),
      ),
    );
  }
}
