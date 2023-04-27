import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/Suit.dart';
import '../utils/color.dart';
import '../utils/file_to_multipart.dart';
import '../utils/url.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuitDao {
  static const String getAllSuitsUrl = "/wardrobe/get_all_suits";

  static const String deleteSuitUrl = "/wardrobe//delete_suit";

  static const String uploadSuitUrl = "/wardrobe/upload_suit";

  static Future<List<Suit>> getAllSuits(int id) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'id': id};

      Response response =
          await dio.get(getAllSuitsUrl, queryParameters: params);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.toString());

        print(response.data.toString());

        List<Suit> allSuits = data['suitList']
            .map<Suit>((json) => Suit.fromJson((json) as Map<String, dynamic>))
            .toList();

        return allSuits;
      } else {
        throw Exception('请求失败');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('异常');
    }
  }

  static Future<Suit> uploadSuit(
      File image, int userId, List<int?> clothesIds) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));

      MultipartFile imageMulti = await fileToMultipartFile(image);

      FormData formData = FormData.fromMap({
        'image': imageMulti,
        'userId': userId,
        'topId': clothesIds[0],
        'bottomId': clothesIds[1],
        'outwearId': clothesIds[2],
        'shoesId': clothesIds[3],
        'accessoryId1': clothesIds[4],
        'accessoryId2': clothesIds[5]
      });

      Response response = await dio.post(uploadSuitUrl, data: formData);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Upload successfully!',
            gravity: ToastGravity.CENTER,
            textColor: gold,
            backgroundColor: Colors.white);
        if (response.data == null) {
          Fluttertoast.showToast(
              msg: '上传失败！',
              gravity: ToastGravity.CENTER,
              textColor: Colors.grey);
          throw Exception('上传失败！');
        }
        return Suit.fromJson(response.data);
      } else {
        // 请求失败，抛出异常
        throw Exception('上传失败！！！');
      }
    } catch (e) {
      throw Exception('网络异常');
    }
  }

  static void deleteSuit(int userId, int suitId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'suitId': suitId, 'userId': userId};

      Response response = await dio.get(deleteSuitUrl, queryParameters: params);

      // print('Response ${response.statusCode}');
      print(response.data);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Delete successfully!',
            gravity: ToastGravity.CENTER,
            textColor: gold,
            backgroundColor: Colors.white);
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
