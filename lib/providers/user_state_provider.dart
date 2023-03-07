import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserStateProvider with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  late User? _currentUser;

  User? get currentUser => _currentUser;

  set userState(User? user) {
    _currentUser = user;
    notifyListeners();
  }
}
