import 'dart:io';

import 'package:dio/dio.dart';

Future<MultipartFile> fileToMultipartFile(File file) async {
  final multipartFile = await MultipartFile.fromFile(
    file.path,
    filename: file.path.split('/').last,
  );
  return multipartFile;
}


