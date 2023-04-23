import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/page/clothes/cloth_tag.dart';
import '../../dao/clothes_dao.dart';
import '../../model/Clothes.dart';
import '../../store.dart';
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
  late List<Clothes> _clothesList;

  late List<String> images;

  // late List<String> images = [
  //   'https://picsum.photos/id/1018/250/250',
  //   'https://picsum.photos/id/1025/250/250',
  //   'https://picsum.photos/id/1041/250/250',
  //   'https://picsum.photos/id/1050/250/250',
  //   'https://picsum.photos/id/1060/250/250',
  //   'https://picsum.photos/id/1074/250/250',
  //   'https://picsum.photos/id/1080/250/250',
  //   'https://picsum.photos/id/109/250/250',
  //   'https://picsum.photos/id/110/250/250',
  //   'https://picsum.photos/id/111/250/250',
  //   'https://picsum.photos/id/112/250/250',
  //   'http://localhost:8080/get_clothes_image?userId=1&clothesId=8',
  // ];

  late File _image;

  @override
  void initState() {
    super.initState();
    // _requestPermissions();
    // _image = null;
  }

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print(pickedFile.path);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClothTagPage(
            image: _image,
            userId: widget.userId,
            selectedIndex: widget.selectedIndex,
          ),
        ),
      );
    }
  }

  void _showPictureDetail(
      BuildContext context, String imageUrl, Clothes clothes) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClothesDetailPage(
          imageUrl: imageUrl,
          clothes: clothes,
          userId: widget.userId,
        ),
      ),
    );
  }

  void _showForm(BuildContext context, String imageUrl, Clothes clothes) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(children: [
          Padding(
              padding: EdgeInsets.all(30.0),
              child: AspectRatio(
                aspectRatio: 1.0, // 设置宽高比为1:1
                child: Image.network(
                  imageUrl, // 替换为您的图像URL
                  fit: BoxFit.scaleDown, // 图像填充方式
                ),
              )),
          ElevatedButton(
            onPressed: () {
              print("delete");
              Provider.of<StoreProvider>(context, listen: false)
                  .deleteClothes(clothes);
              ClothesDao.deleteClothes(widget.userId, clothes.id);
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
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
                _showForm(context, images[index], _clothesList[index]);
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
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
