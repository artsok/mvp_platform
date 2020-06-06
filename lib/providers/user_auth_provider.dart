import 'package:flutter/material.dart';

class UserAuth with ChangeNotifier {
  bool authenticated = false;

  Future<bool> authenticate() async {
    if (!authenticated) {
      authenticated = await Future.delayed(Duration(seconds: 2), () => false);
      notifyListeners();
    }
    return authenticated;
  }
}
