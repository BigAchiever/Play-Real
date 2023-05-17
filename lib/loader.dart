import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:play_real/background.dart';

class LoadingScreen extends StatelessWidget {
  // final String text;
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/loading';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width / 1.4,
            child: Text(
              "Please wait while we load your game...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: SpinKitPouringHourGlassRefined(
              color: Colors.orangeAccent,
              duration: Duration(seconds: 2),
              size: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
