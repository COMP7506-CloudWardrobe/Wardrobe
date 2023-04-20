import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/User.dart';
import '../utils/url.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDao {
  static const String loginUrl = "/account/login";
  static const String registerUrl = "/account/register";

  // 登录方法，传入用户名和密码，返回User对象
  static Future<User> login(String email, String password) async {
    try {
      // print('------test------');
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      FormData formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      Response response = await dio.post(loginUrl, data: formData);

      print('Response ${response.statusCode}');
      print(response.data);

      if (response.statusCode == 200) {
        // 请求成功，解析返回的数据
        // print("-------test------");
        if(response.data == null) {
          Fluttertoast.showToast(
              msg: '邮箱或密码错误！',
              gravity: ToastGravity.CENTER,
              textColor: Colors.grey);
          throw Exception('登录失败');
        }
        var data = jsonDecode(response.toString());
        User user = User(email: data['email'], password: data['password'], id: data['userId'], userName: data['userName']);
        return user;
      } else {
        // 请求失败，抛出异常
        throw Exception('登录失败');
      }
    } catch (e) {
      // 请求异常，抛出异常
      // Fluttertoast.showToast(
      //     msg: '网络异常！',
      //     gravity: ToastGravity.CENTER,
      //     textColor: Colors.grey);
      throw Exception('网络异常');
    }
  }

  // 注册方法，传入用户名、邮箱和密码，返回User对象
  static Future<User> register(String username, String email, String password) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      var formData = {
        'userName': username,
        'email': email,
        'password': password,
      };
      Response response = await dio.post(registerUrl, data: formData);

      if (response.statusCode == 200) {
        // 请求成功，解析返回的数据
        var data = jsonDecode(response.toString());
        User user = User(email: data['email'], password: data['password'], id: data['userId'], userName: data['userName']);
        return user;
      } else {
        // 请求失败，抛出异常
        throw Exception('注册失败');
      }
    } catch (e) {
      // 请求异常，抛出异常
        throw Exception('网络异常');
      }
  }


}
