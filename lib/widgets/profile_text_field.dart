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
      maxLength: 22,
      decoration: InputDecoration(
        counterStyle: TextStyle(color: commonGreyColor),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(50),
        ),
        hintText: "Say something here...",
        hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
        filled: true,
        fillColor: StartingScreenState.lightmodedarkmode
            ? Color(0xff5F9EA0)
            : Colors.grey[900],
      ),
    ),
  );
}
