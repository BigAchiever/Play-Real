import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/widgets.dart';

import '../constants/constants.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
}

class AuthAPI extends ChangeNotifier {
  User? _currentUser;

  AuthStatus _status = AuthStatus.uninitialized;
  final account = Account(client);
  // Getter methods
  User? get currentUser => _currentUser;

  AuthStatus get status => _status;
  String? get username => _currentUser?.name;
  String? get userid => _currentUser?.$id;
  ValueNotifier<bool> isFacebookAuthenticated = ValueNotifier<bool>(false);

  // Constructor
  AuthAPI() {
    loadUser();
  }

  loadUser() async {
    try {
      final user = await account.get();
      _status = AuthStatus.authenticated;
      _currentUser = user;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    }
  }

  Future<void> signInWithFacebook({required String provider}) async {
    try {
      final session = await account.createOAuth2Session(provider: provider);
      _currentUser = await account.get();

      isFacebookAuthenticated.value = true;
      _status = AuthStatus.authenticated;
      return session;
    } finally {
      notifyListeners();
    }
  }

  signOut() async {
    try {
      await account.deleteSession(sessionId: '[SESSION_ID]');
      _status = AuthStatus.unauthenticated;
      isFacebookAuthenticated.value = false;
    } finally {
      notifyListeners();
    }
  }

  Future<Preferences> getUserPreferences() async {
    return await account.getPrefs();
  }

  updatePreferences({required String bio}) async {
    return account.updatePrefs(prefs: {'bio': bio});
  }
}
