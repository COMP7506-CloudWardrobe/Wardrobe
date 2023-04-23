import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/dao/suit_dao.dart';
import 'package:wardrobe/utils/url.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

import '../../model/Clothes.dart';
import '../../model/Suit.dart';
import '../../store.dart';

class SuitUploadPage extends StatefulWidget {
  @override
  State<SuitUploadPage> createState() => _SuitUploadPageState();
}

class _SuitUploadPageState extends State<SuitUploadPage> {
  GlobalKey _globalKey = GlobalKey();

  late File screenshot;

  late List<Clothes> _clothesList;
  late int _userId;
  late List<String?> images = [null, null, null, null, null, null];
  late List<int?> selectedClothesIds = [null, null, null, null, null, null];
  final List<String> _addClothesCategory = [
    "Add top",
    "Add bottom",
    "Add outwear",
    "Add shoes",
    "Add accessory1",
    "Add accessory2"
  ];

  void _submit() {}

  void showFormDialog(BuildContext context, int type) {
    _clothesList = Provider.of<StoreProvider>(context, listen: false)
        .getClothesList(type)!;
    List<String> clothesImages = _clothesList
        .map((clothes) => getClothesImageURL(clothes.id, _userId))
        .toList();

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5, // 设置高度为屏幕高度的50%
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
              ),
              itemCount: clothesImages.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      images[type] = clothesImages[index];
                      selectedClothesIds[type] = _clothesList[index].id;
                    });
                    // 返回图片ID并关闭弹窗
                    Navigator.pop(context);
                  },
                  child: Image.network(
                    clothesImages[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget getClothesPicker(int type) {
    return GestureDetector(
      onTap: () {
        // 点击图片选择框时选择图片
        showFormDialog(context, type);
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: images[type] != null
                ? Image.network(images[type]!)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                          Icons.add_a_photo,
                          size: 36,
                        ),
                        Text(_addClothesCategory[type])
                      ])),
      ),
    );
  }

  Future<File> captureScreenshot() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    // 获取应用程序的临时目录
    // Directory tempDir = await getApplicationDocumentsDirectory();
    // 创建文件对象，并指定文件路径
    File file = File(
        '/Users/celiaf/Documents/HKU/wardrobe/Wardrobe/assets/tmp/screenshot.png');
    // 将字节数据写入文件
    await file.writeAsBytes(pngBytes);
    return file;
  }

  void _captureAndUpload() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      File image = await captureScreenshot();
      SuitDao.uploadSuit(image, _userId, selectedClothesIds).then((suit) {
        Provider.of<StoreProvider>(context, listen: false).addSuit(suit);
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _userId = Provider.of<StoreProvider>(context, listen: false).user.id;

    return Scaffold(
        appBar: AppBar(
          title: Text('Suit Planner'),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
            // 设置内边距
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 上部分：top, bottom, one-piece
                RepaintBoundary(
                    key: _globalKey,
                    child: Container(
                        color: Colors.white,
                        child: Expanded(
                          child: Row(
                            children: [
                              // 左侧：top, bottom, shoes
                              Expanded(
                                child: Column(
                                  children: [
                                    // top
                                    getClothesPicker(0),
                                    Container(height: 10),
                                    // bottom
                                    getClothesPicker(1),
                                    Container(height: 10),
                                    // shoes
                                    getClothesPicker(3),
                                    // accessory
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),

                              Expanded(
                                  child: Column(children: [
                                // 右侧：outwear, accessory1, accessory2
                                getClothesPicker(2),
                                Container(height: 10),
                                getClothesPicker(4),
                                Container(height: 10),
                                getClothesPicker(5),
                              ]))
                            ],
                          ),
                        ))),
                Column(
                  children: [
                    // shoes
                    ElevatedButton(
                      onPressed: () {
                        _captureAndUpload();
                        // Navigator.pop(context);
                      },
                      child: const Text('Submit'),
                    ),
                    // accessory
                    // Expanded(child: buildImagePicker(4)),
                  ],
                ),
              ],
            )));
  }
}
