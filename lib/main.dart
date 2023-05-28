import 'package:flutter/material.dart';
import 'package:play_real/provvider/player_age_provider.dart';
import 'package:provider/provider.dart';
import 'appwrite/auth.dart';
import 'screens/home.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthAPI>(
          create: (context) => AuthAPI(),
        ),
        ChangeNotifierProvider<PlayerAgeProvider>(
          create: (context) => PlayerAgeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Play Real',
        home: const StartingScreen(),
      ),
    );
  }
}
