
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
