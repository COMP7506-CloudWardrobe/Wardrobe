
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wardrobe/utils/file_to_multipart.dart';

import '../utils/url.dart';

class WardrobeDao {
  static const String uploadClothesUrl = "/wardrobe/upload_clothes";

  static Future<bool> uploadClothes(File image, int userId, int type) async{
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseURL));
      MultipartFile imageMulti = await fileToMultipartFile(image);
      // print(userId);
      // print(imageMulti);
      FormData formData = FormData.fromMap({
        'image': imageMulti,
        'userId': userId,
        'type': type
      });
      Response response = await dio.post(uploadClothesUrl, data: formData);

      if (response.statusCode == 200) {
        // 请求成功，解析返回的数据
        // print("-------test------");
        if(response.data == null) {
          Fluttertoast.showToast(
              msg: '上传失败！',
              gravity: ToastGravity.CENTER,
              textColor: Colors.grey);
          throw Exception('上传失败！');
        }
        return response.data;
      } else {
        // 请求失败，抛出异常
        throw Exception('上传失败！！！');
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
}
