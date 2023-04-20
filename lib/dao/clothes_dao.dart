import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/url.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wardrobe/model/ClothesWardrobe.dart';
import 'package:wardrobe/model/Clothes.dart';

class ClothesDao {
  static const String getAllClothesUrl = "/wardrobe/get_all_clothes";

  static Future<ClothesWardrobe> getAllClothes(int id) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      Map<String, dynamic> params = {'id': 1};
      Response response =
          await dio.get(getAllClothesUrl, queryParameters: params);

      print('Response ${response.statusCode}');
      print(response.data);

      if (response.statusCode == 200) {

        var data = jsonDecode(response.toString());

        ClothesWardrobe allClothes = ClothesWardrobe(
            tops: data['tops']
                ?.map<Clothes>(
                    (json) => Clothes.fromJson(json as Map<String, dynamic>))
                .toList(),
            bottoms: data['bottoms']
                ?.map<Clothes>((json) => Clothes.fromJson(json))
                .toList(),
            onePieces: data['onePieces']
                ?.map<Clothes>((json) => Clothes.fromJson(json))
                .toList(),
            shoes: data['shoes']
                ?.map<Clothes>((json) => Clothes.fromJson(json))
                .toList(),
            accessories: data['accessories']
                ?.map<Clothes>((json) => Clothes.fromJson(json))
                .toList());
        return allClothes;

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
