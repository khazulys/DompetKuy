import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';
  bool _isOnboarded = false;
  bool _isLoading = true;

  String get userName => _userName;
  bool get isOnboarded => _isOnboarded;
  bool get isLoading => _isLoading;

  UserProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('userName') ?? '';
    _isOnboarded = prefs.getBool('isOnboarded') ?? false;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> setUserName(String name) async {
    _userName = name;
    _isOnboarded = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setBool('isOnboarded', true);

    notifyListeners();
  }

  Future<void> updateUserName(String name) async {
    _userName = name;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);

    notifyListeners();
  }
}
