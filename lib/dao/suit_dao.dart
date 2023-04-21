import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/Suit.dart';
import '../utils/url.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wardrobe/model/ClothesWardrobe.dart';
import 'package:wardrobe/model/Clothes.dart';

class SuitDao {
  static const String getAllSuitsUrl = "/wardrobe/get_all_suits";

  static const String deleteSuitUrl = "/wardrobe//delete_suit";

  static Future<List<Suit>> getAllSuits(int id) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'id': id};

      Response response =
          await dio.get(getAllSuitsUrl, queryParameters: params);

      // print('Response ${response.statusCode}');
      print(response.data);
      print('!!!');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.toString());

        print(response.data.toString());

        List<Suit> allSuits = data['suitList']
            .map<Suit>((json) => Suit.fromJson((json) as Map<String, dynamic>))
            .toList();

        return allSuits;
      } else {
        // 请求失败，抛出异常
        throw Exception('请求失败');
      }
    } catch (e) {
      // 请求异常，抛出异常
      // Fluttertoast.showToast(
      //     msg: '网络异常！',
      //     gravity: ToastGravity.CENTER,
      //     textColor: Colors.grey);
      print(e.toString());
      throw Exception('异常');
    }
  }

  static void deleteClothes(int userId, int clothesId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'suitId': clothesId, 'userId': userId};

      Response response = await dio.get(deleteSuitUrl, queryParameters: params);

      // print('Response ${response.statusCode}');
      print(response.data);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Delete successfully.',
            gravity: ToastGravity.CENTER,
            textColor: Colors.grey);
      } else {
        // 请求失败，抛出异常
        throw Exception('请求失败');
      }
    } catch (e) {
      // 请求异常，抛出异常
      // Fluttertoast.showToast(
      //     msg: '网络异常！',
      //     gravity: ToastGravity.CENTER,
      //     textColor: Colors.grey);
      throw Exception('异常');
    }
  }
}
