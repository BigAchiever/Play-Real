import 'package:flutter/material.dart';
import 'package:play_real/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://amjxawskarnqmksbgmme.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFtanhhd3NrYXJucW1rc2JnbW1lIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQ2NTI5NzIsImV4cCI6MjAwMDIyODk3Mn0.myKkC9DlAohatzZ3U9t75pBkGG051i2wR3jP66iLZwo',
  );

  runApp(const MyApp());
}

// final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Play Real',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartingScreen(),
    );
  }
}
