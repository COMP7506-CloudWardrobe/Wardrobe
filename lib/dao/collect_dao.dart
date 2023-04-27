import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/Share.dart';
import '../utils/color.dart';
import '../utils/url.dart';

class CollectDao {
  static const String getAllUrl = "/collect/get_collections";

  static const String collectUrl = "/collect/collect";

  static const String deleteUrl = "/collect/delete";

  static Future<List<Share>> getCollections(int userId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'userId': userId};

      Response response = await dio.get(getAllUrl, queryParameters: params);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.toString());
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

  static void collect(int shareId, int userId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'shareId': shareId, 'userId': userId};

      Response response = await dio.post(collectUrl, queryParameters: params);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Collect successfully!',
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

  static void deleteCollect(int shareId, int userId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'shareId': shareId, 'userId': userId};

      Response response = await dio.post(deleteUrl, queryParameters: params);

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
