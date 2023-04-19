import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/User.dart';
import '../utils/url.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDao {
  static const String loginUrl = "/api/login";

  // 登录方法，传入用户名和密码，返回User对象
  static Future<User> login(String email, String password) async {
    try {
      print('------test------');
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Response response = await dio.post(loginUrl, data: {'email': email, 'password': password});
      print('Response ${response.statusCode}');
      print(response.data);

      if (response.statusCode == 200) {
        // 请求成功，解析返回的数据
        Fluttertoast.showToast(
            msg: '登录成功！',
            gravity: ToastGravity.CENTER,
            textColor: Colors.grey);
        Map<String, dynamic> data = json.decode(response.data);
        User user = User(email: data['email'], password: data['password'], userToken: data['userToken']);
        return user;
      } else {
        // 请求失败，抛出异常
        throw Exception('登录失败');
      }
    } catch (e) {
      // 请求异常，抛出异常
      throw Exception('网络异常');
    }
  }
}
