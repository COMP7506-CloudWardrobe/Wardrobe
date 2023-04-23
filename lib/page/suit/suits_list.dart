import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/dao/suit_dao.dart';
import 'package:wardrobe/page/suit/suit_detail.dart';
import 'package:wardrobe/page/suit/suit_upload.dart';
import 'package:wardrobe/utils/color.dart';
import 'package:wardrobe/utils/url.dart';
import '../../model/Clothes.dart';
import '../../model/Suit.dart';
import '../../store.dart';

class SuitPictureList extends StatefulWidget {
  @override
  State<SuitPictureList> createState() => _SuitPictureListState();

  int userId;

  SuitPictureList({super.key, required this.userId});
}

class _SuitPictureListState extends State<SuitPictureList> {
  late List<Suit> _suitList;

  late List<String> images;

  void _showForm(BuildContext context, String imageUrl, Suit suit) {
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
          TextButton(
              onPressed: () {
                Provider.of<StoreProvider>(context, listen: false)
                    .deleteSuit(suit);
                SuitDao.deleteSuit(widget.userId, suit.suitId);
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

  void _showPictureDetail(BuildContext context, String imageUrl, Suit suit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuitDetailPage(
          imageUrl: imageUrl,
          suit: suit,
          userId: widget.userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _suitList = Provider.of<StoreProvider>(context, listen: true).getSuitList();

    images = _suitList
        .map((Suit suit) => getSuitImageURL(suit.suitId, widget.userId))
        .toList();

    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 10.0, // Spacing between columns
            mainAxisSpacing: 10.0, // Spacing between rows
            childAspectRatio: 0.6),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print(index);
              _showForm(context, images[index], _suitList[index]);
              // ClothesDetailPage(imageUrl: images[index]);
              // _showForm(context, images[index]);
            },
            child: Image.network(
              images[index],
              fit: BoxFit.scaleDown,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuitUploadPage(),
            ),
          );
          // Handle add button tap here
        },
        child: Icon(Icons.add),
        backgroundColor: green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
