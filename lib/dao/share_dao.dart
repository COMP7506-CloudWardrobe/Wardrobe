import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wardrobe/model/Clothes.dart';
import 'package:wardrobe/utils/file_to_multipart.dart';

import '../model/Share.dart';
import '../utils/color.dart';
import '../utils/url.dart';

class ShareDao {
  static const String getAllSharesUrl = "/share/get_all_shares";

  static const String getUserSharesUrl = "/share/get_user_shares";

  static const String shareSuitUrl = "/share/share_suit";

  static const String deleteShareUrl = "/share/delete_share";

  static Future<List<Share>> getAllShares() async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));

      Response response = await dio.get(getAllSharesUrl);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.toString());

        print(response.data.toString());

        List<Share> allShares = data['shareList']
            .map<Share>(
                (json) => Share.fromJson((json) as Map<String, dynamic>))
            .toList();

        return allShares;
      } else {
        throw Exception('请求失败');
      }
    } catch (e) {
      throw Exception('异常');
    }
  }

  static Future<List<Share>> getUserShares(int userId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'userId': userId};

      Response response =
          await dio.get(getUserSharesUrl, queryParameters: params);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.toString());

        print(response.data.toString());

        List<Share> allShares = data['shareList']
            .map<Share>(
                (json) => Share.fromJson((json) as Map<String, dynamic>))
            .toList();

        return allShares;
      } else {
        throw Exception('请求失败');
      }
    } catch (e) {
      throw Exception('异常');
    }
  }

  static Future<Share> shareSuit(int userId, int suitId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'userId': userId, 'suitId': suitId};

      Response response = await dio.post(shareSuitUrl, queryParameters: params);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Share successfully!',
            gravity: ToastGravity.CENTER,
            textColor: gold,
            backgroundColor: Colors.white);
        print(response.data);
        return Share.fromJson(response.data);
      } else {
        throw Exception('请求失败');
      }
    } catch (e) {
      throw Exception('异常');
    }
  }

  static void deleteShare(int shareId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'shareId': shareId};

      Response response =
          await dio.post(deleteShareUrl, queryParameters: params);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Delete successfully!',
            gravity: ToastGravity.CENTER,
            textColor: gold,
            backgroundColor: Colors.white);
      } else {
        throw Exception('请求失败');
      }
    } catch (e) {
      throw Exception('异常');
    }
  }
}
