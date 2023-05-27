import 'package:flutter/material.dart';

import 'package:play_real/screens/home.dart';
import 'package:provider/provider.dart';

import 'appwrite/auth.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthAPI(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Play Real',
      home: const StartingScreen(),
    );
  }
}
