import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserData {
  static UserModel? _user;
  static UserData? _instance;

  factory UserData() {
    if (_instance == null) {
      _instance = UserData._internal();
    }
    return _instance!;
  }

  UserData._internal();

  static UserModel? get user => _user;

  static Future<void> updateUser(UserModel updatedUser) async {
    _user = updatedUser;
    await saveUser(updatedUser);
  }

  static Future<void> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Konversi UserModel menjadi bentuk JSON menggunakan toJson()
    String userJson = jsonEncode(user.toJson());

    // Simpan userJson di SharedPreferences
    await prefs.setString('user', userJson);
  }

  static Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil userJson dari SharedPreferences
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      // Konversi userJson menjadi UserModel menggunakan fromJson()
      _user = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  static Future setToken(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token!);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token ?? '';
  }

}