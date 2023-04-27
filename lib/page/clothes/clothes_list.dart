import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/page/clothes/cloth_tag.dart';
import '../../dao/clothes_dao.dart';
import '../../model/Clothes.dart';
import '../../store.dart';
import '../../utils/color.dart';
import 'clothes_detail.dart';
import '../../utils/url.dart';

class ClothesPictureList extends StatefulWidget {
  @override
  State<ClothesPictureList> createState() => _ClothesPictureListState();

  int clothesType;

  int userId;

  int selectedIndex;

  ClothesPictureList(
      {super.key,
      required this.clothesType,
      required this.userId,
      required this.selectedIndex});
}

class _ClothesPictureListState extends State<ClothesPictureList> {
  late int _uploadTypeIndex;

  late List<Clothes> _clothesList;

  late List<String> images;

  late File _image;

  @override
  void initState() {
    super.initState();
    // _requestPermissions();
    // _image = null;
  }

  Future<void> _selectImage() async {
    ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _showUploadForm(context);
      }
    });
  }

  void _upload() {
    print('--------upload--------');
    // print(type);
    ClothesDao.uploadClothes(_image, widget.userId, _uploadTypeIndex)
        .then((result) => {
              Provider.of<StoreProvider>(context, listen: false)
                  .addClothes(result),
              Navigator.pop(context)
            });
  }

  void _showUploadForm(BuildContext context) {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
              // height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(
                      height: min(MediaQuery.of(context).size.height * 0.5,
                          MediaQuery.of(context).size.width * 0.8),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Image.file(
                          _image,
                          fit: BoxFit.scaleDown,
                        ),
                      ))),
              // SizedBox(
              //     height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            'Type:',
                            style: TextStyle(fontSize: 16),
                          )),
                      // const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: DropdownButton<int>(
                          value: _uploadTypeIndex,
                          alignment: Alignment.center,
                          iconSize: 16,
                          style: const TextStyle(color: green, fontSize: 16),
                          onChanged: (int? newValue) {
                            setState(() {
                              _uploadTypeIndex = newValue!;
                            });
                          },
                          items: const <DropdownMenuItem<int>>[
                            DropdownMenuItem(
                              value: 0,
                              child: Text('Top'),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Bottom'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('Outwear'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('Shoes'),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text('Accessory'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: TextButton(
                            onPressed: _upload,
                            style: TextButton.styleFrom(
                                foregroundColor: gold,
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text('Upload'),
                          )),
                    ],
                  )),
            ],
          ));
        });
      },
    );
  }

  void _showDeleteForm(BuildContext context, String imageUrl, Clothes clothes) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(children: [
          Padding(
              padding: EdgeInsets.all(30.0),
              child: SizedBox(
                  height: min(MediaQuery.of(context).size.height * 0.5,
                      MediaQuery.of(context).size.width * 0.8),
                  child: AspectRatio(
                    aspectRatio: 1.0, // 设置宽高比为1:1
                    child: Image.network(
                      imageUrl, // 替换为您的图像URL
                      fit: BoxFit.scaleDown, // 图像填充方式
                    ),
                  ))),
          TextButton(
              onPressed: () {
                Provider.of<StoreProvider>(context, listen: false)
                    .deleteClothes(clothes);
                ClothesDao.deleteClothes(widget.userId, clothes.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  foregroundColor: gold,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              child: const Text('Delete')),
          const SizedBox(height: 10.0),
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _clothesList = Provider.of<StoreProvider>(context, listen: true)
        .getClothesList(widget.clothesType)!;

    images = _clothesList
        .map((Clothes clothes) => getClothesImageURL(clothes.id, widget.userId))
        .toList();

    _uploadTypeIndex = widget.selectedIndex;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0), // 设置内边距
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0 // Spacing between rows
              ),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print(index);
                // _showPictureDetail(context, images[index], _clothesList[index]);
                // ClothesDetailPage(imageUrl: images[index]);
                _showDeleteForm(context, images[index], _clothesList[index]);
              },
              child: Image.network(
                images[index],
                fit: BoxFit.scaleDown,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectImage,
        child: Icon(Icons.camera_alt),
        backgroundColor: green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
