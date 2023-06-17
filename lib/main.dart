import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_real/provider/player_age_provider.dart';
import 'package:provider/provider.dart';
import 'network/auth.dart';
import 'screens/home.dart';
import 'widgets/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        home: SplashScreen(),
        routes: {'/home': (context) => StartingScreen()},
      ),
    );
  }
}
