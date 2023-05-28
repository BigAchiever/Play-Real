import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerAgeProvider with ChangeNotifier {
  Duration playerAge = Duration.zero;
  Timer? timer;

  PlayerAgeProvider() {
    loadPlayerAge();
    calculatePlayerAge();
  }

  Future<void> loadPlayerAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime? storedDate =
        DateTime.fromMillisecondsSinceEpoch(prefs.getInt('playerAgeDate') ?? 0);
    DateTime currentDate = DateTime.now();

    // ignore: unnecessary_null_comparison
    if (storedDate != null) {
      int days = currentDate.difference(storedDate).inDays;
      playerAge = Duration(days: days);
    } else {
      playerAge = Duration.zero;
    }
  }

  Future<void> savePlayerAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('playerAgeDate', DateTime.now().millisecondsSinceEpoch);
  }

  void calculatePlayerAge() {
    const Duration oneDay = Duration(days: 1);

    timer = Timer.periodic(oneDay, (timer) {
      playerAge += oneDay;
      savePlayerAge();
      notifyListeners();
    });
  }

  String formatDuration(Duration duration) {
    int days = duration.inDays;
    return '$days d';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
