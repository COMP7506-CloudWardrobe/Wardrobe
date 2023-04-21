
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe/dao/wardrobe_dao.dart';
import 'package:wardrobe/page/clothes/clothes_list.dart';

import 'clothes_page.dart';

class ClothTagPage extends StatefulWidget {
  late File image;

  int userId;

  ClothTagPage({super.key, required this.image, required this.userId});

  @override
  State<ClothTagPage> createState() => _ClothTagPageState();
}

class _ClothTagPageState extends State<ClothTagPage> {
  int type = 0;
  double rotationAngle = 0;

  void _upload() {
    print('--------upload--------');
    // print(type);
    WardrobeDao.uploadClothes(widget.image, widget.userId, type).then((result) => {
      if(result) {
        Navigator.pushReplacement(
          context,
            MaterialPageRoute(
              builder: (context) => ClothesPage(),
          ),
        )
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RotatedBox(
              quarterTurns: rotationAngle ~/ 90,
              child: Image.file(widget.image! as File),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rotationAngle += 90;
                });
              },
              child: const Text('rotate'),
            ),
            Row(
              children: [
                const Text('Type'),
                const SizedBox(width: 16),
                Expanded(
                  child:  DropdownButton<int>(
                    value: type,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.blueAccent,
                    ),
                    onChanged: (int? newValue) {
                      setState(() {
                        type = newValue!;
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
                        child: Text('One-Piece'),
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
              child: ElevatedButton(
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