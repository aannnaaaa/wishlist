import 'package:flutter/foundation.dart';

class SettingsStore extends ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'English';
  bool _notificationsEnabled = true;

  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  bool get notificationsEnabled => _notificationsEnabled;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }
}
