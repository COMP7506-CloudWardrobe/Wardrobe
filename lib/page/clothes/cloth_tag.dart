import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/dao/clothes_dao.dart';
import 'package:wardrobe/dao/wardrobe_dao.dart';
import 'package:wardrobe/page/clothes/clothes_list.dart';

import '../../store.dart';
import '../../utils/color.dart';
import 'clothes_page.dart';

class ClothTagPage extends StatefulWidget {
  late File image;

  int userId;

  int selectedIndex;

  ClothTagPage(
      {super.key,
      required this.image,
      required this.userId,
      required this.selectedIndex});

  @override
  State<ClothTagPage> createState() => _ClothTagPageState();
}

class _ClothTagPageState extends State<ClothTagPage> {

  void _upload() {
    print('--------upload--------');
    // print(type);
    ClothesDao.uploadClothes(widget.image, widget.userId, widget.selectedIndex)
        .then((result) => {
              Provider.of<StoreProvider>(context, listen: false)
                  .addClothes(result),
              Navigator.pop(context)
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40,60,40,40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.0, // 设置宽高比为1:1
              child: Image.file(
                widget.image, // 替换为您的图像URL
                fit: BoxFit.scaleDown, // 图像填充方式
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Type'),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<int>(
                    value: widget.selectedIndex,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: green),
                    underline: Container(
                      height: 2,
                      color: gold,
                    ),
                    onChanged: (int? newValue) {
                      setState(() {
                        widget.selectedIndex = newValue!;
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
                )
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: _upload,
                child: const Text('upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
