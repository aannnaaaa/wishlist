import 'package:flutter/foundation.dart';

class UserStore extends ChangeNotifier {
  String _userName = 'User Name';

  String get userName => _userName;

  void updateUserName(String newName) {
    _userName = newName;
    notifyListeners();
  }
}
