import 'package:flutter/material.dart';

class AuthStateProvider extends ChangeNotifier {
  bool _isFacebookLoggedIn = false;

  bool get isFacebookLoggedIn => _isFacebookLoggedIn;

  void setFacebookLoggedIn(bool isLoggedIn) {
    _isFacebookLoggedIn = isLoggedIn;
    notifyListeners();
  }
}
