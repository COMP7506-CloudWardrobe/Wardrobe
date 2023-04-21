import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image/image.dart';

Future<MultipartFile> fileToMultipartFile(File image) async {
  Image imageBytes = decodeImage(await image.readAsBytes())!;
  List<int> compressedImage = encodeJpg(imageBytes, quality: 60);

  final multipartFile = MultipartFile.fromBytes(
    compressedImage,
    filename: image.path.split('/').last,
  );
  return multipartFile;
}
