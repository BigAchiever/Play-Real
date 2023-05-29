import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        width: 100.0,
        height: 100.0,
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

class ImageDialog extends StatelessWidget {
  final List<String> imageUrls = [
    "assets/images/avatars/2.png",
    "assets/images/avatars/3.png",
    "assets/images/avatars/4.png",
    "assets/images/avatars/5.png",
    "assets/images/avatars/6.png",
    "assets/images/avatars/7.png",
    "assets/images/avatars/8.png",
    "assets/images/avatars/9.png",
    "assets/images/avatars/10.png",
    "assets/images/avatars/11.png",
    "assets/images/avatars/12.png",
    "assets/images/avatars/13.png",
    "assets/images/avatars/14.png",
    "assets/images/avatars/15.png",
  ];

  final Function(String) onImageTap; // Callback function

  ImageDialog({required this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: CarouselSlider(
          items: imageUrls.map((imageUrl) {
            return GestureDetector(
              onTap: () =>
                  onImageTap(imageUrl), // Trigger the callback on image tap
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                height: 200.0,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            viewportFraction: 0.4,
            initialPage: 0,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            enlargeFactor: 0.55,
            enableInfiniteScroll: true,
            autoPlay: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}
