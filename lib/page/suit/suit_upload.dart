import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/dao/suit_dao.dart';
import 'package:wardrobe/model/ClothesWardrobe.dart';
import 'package:wardrobe/utils/url.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

import '../../model/Clothes.dart';
import '../../model/Suit.dart';
import '../../store.dart';
import '../../utils/color.dart';

class SuitUploadPage extends StatefulWidget {
  @override
  State<SuitUploadPage> createState() => _SuitUploadPageState();
}

class _SuitUploadPageState extends State<SuitUploadPage> {
  final GlobalKey _globalKey = GlobalKey();

  late File screenshot;

  late ClothesWardrobe _wardrobe;

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

  void showFormDialog(BuildContext context, int type) {
    setState(() {
      _clothesList = _wardrobe.getClothesList(type)!;
    });
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
                height:
                    MediaQuery.of(context).size.height * 0.4, // 设置高度为屏幕高度的50%
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                    child: Column(children: [
                      _clothesList.isNotEmpty
                          ? Expanded(
                              // flex: 5,
                              child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    3, // Number of columns in the grid
                                crossAxisSpacing:
                                    10.0, // Spacing between columns
                                mainAxisSpacing: 10.0, // Spacing between rows
                              ),
                              itemCount: clothesImages.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      images[type] = clothesImages[index];
                                      selectedClothesIds[type] =
                                          _clothesList[index].id;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Image.network(
                                    clothesImages[index],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ))
                          : Expanded(
                              child: Container(
                                  color: Colors.white,
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('Nothing here :)')))),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            images[type] = null;
                            selectedClothesIds[type] = null;
                          });
                          Navigator.pop(context); // 关闭弹窗
                        },
                        child: const Text('Clear'),
                      ),
                    ]))));
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
                        const Icon(
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      File image = await captureScreenshot();
      SuitDao.uploadSuit(image, _userId, selectedClothesIds).then((suit) {
        Provider.of<StoreProvider>(context, listen: false).addSuit(suit);
        Navigator.pop(context);
      });
    });
  }

  void randomOutfit() {
    setState(() {
      for (int type = 0; type < selectedClothesIds.length; type++) {
        List<Clothes>? tmpClothesList = _wardrobe.getClothesList(type);
        if (tmpClothesList != null && tmpClothesList.isNotEmpty) {
          int random = Random().nextInt(tmpClothesList.length);
          selectedClothesIds[type] = tmpClothesList[random].id;
          images[type] = getClothesImageURL(selectedClothesIds[type]!, _userId);
        }
      }
    });
  }

  void clear() {
    setState(() {
      selectedClothesIds = [null, null, null, null, null, null];
      images = [null, null, null, null, null, null];
    });
  }

  @override
  Widget build(BuildContext context) {
    _userId = Provider.of<StoreProvider>(context, listen: false).user.id;
    _wardrobe =
        Provider.of<StoreProvider>(context, listen: true).clothesWardrobe;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suit Planner'),
      ),
      body: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 40.0),
              child: Column(
                children: [
                  // 上部分：top, bottom, one-piece
                  Expanded(
                      child: RepaintBoundary(
                    key: _globalKey,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          // 左侧：top, bottom, shoes
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                          // 右侧：outwear, accessory1, accessory2
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getClothesPicker(2),
                                Container(height: 10),
                                getClothesPicker(4),
                                Container(height: 10),
                                getClothesPicker(5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),

                  // shoes
                  Stack(children: [
                    Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            _captureAndUpload();
                            // Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: gold,
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          child: const Text('Submit'),
                        )),
                    Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () => clear(),
                                icon: const Icon(FontAwesomeIcons.timesCircle,size: 20,),
                                color: green,
                              ),
                              IconButton(
                                onPressed: () => randomOutfit(),
                                icon: const Icon(FontAwesomeIcons.shuffle,size: 20,),
                                color: green,
                              )
                            ]))
                  ]),
                  // accessory
                  // Expanded(child: buildImagePicker(4)),
                ],
              ))),
    );
  }
}
