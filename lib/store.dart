import 'package:flutter/material.dart';
import 'package:wardrobe/model/User.dart';

// 存储全局变量的provider，现在只有存储登录后的用户信息
class StoreProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}