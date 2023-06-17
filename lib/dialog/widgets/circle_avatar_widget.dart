import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_image_dialog_widget.dart';

class AvatarAnimationWidget extends StatefulWidget {
  @override
  _AvatarAnimationWidgetState createState() => _AvatarAnimationWidgetState();
}

class _AvatarAnimationWidgetState extends State<AvatarAnimationWidget> {
  bool ontapped = false;
  String selectedImageUrl =
      "assets/images/avatars/2.png"; // Initially selected image

  @override
  void initState() {
    super.initState();
    loadSelectedAvatar(); // Load the selected avatar when the widget initializes
  }

  Future<void> loadSelectedAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedImageUrl = prefs.getString('selected_avatar');
    if (savedImageUrl != null) {
      setState(() {
        selectedImageUrl = savedImageUrl;
      });
    }
  }

  Future<void> saveSelectedAvatar(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_avatar', imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ontapped = !ontapped;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) => ImageDialog(
            onImageTap: (imageUrl) async {
              setState(() {
                selectedImageUrl = imageUrl; // Set the selected image
              });
              await saveSelectedAvatar(imageUrl); // Save the selected avatar
              Navigator.of(context).pop(); // Close the ImageDialog
            },
          ),
        );
      },
      child: Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(selectedImageUrl), // Use the selected image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
