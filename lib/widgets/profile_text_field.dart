import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';

typedef SavePreferencesCallback = void Function(String bio);

Widget buildTextField3(BuildContext context,
    SavePreferencesCallback onSavePreferences, final bioTextController) {
  return Focus(
    onFocusChange: (hasFocus) {
      if (!hasFocus) {
        onSavePreferences(bioTextController.text);
      }
    },
    child: TextFormField(
      controller: bioTextController,
      textAlign: TextAlign.center,
      cursorColor: const Color.fromRGBO(255, 255, 255, 1),
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Gamefont',
        letterSpacing: 1.1,
      ),
      maxLength: 25,
      decoration: InputDecoration(
        counterStyle: TextStyle(color: commonGreyColor),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(50),
        ),
        hintText: "Write Something Here",
        hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
        filled: true,
        fillColor: StartingScreenState.lightmodedarkmode
            ? lightCommonButton1
            : CommonButton2,
      ),
    ),
  );
}
