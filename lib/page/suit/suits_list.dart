import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/page/suit/suit_detail.dart';
import 'package:wardrobe/utils/url.dart';
import '../../model/Clothes.dart';
import '../../model/Suit.dart';
import '../../store.dart';

class SuitPictureList extends StatefulWidget {
  @override
  State<SuitPictureList> createState() => _SuitPictureListState();
  String getSuitImageURL = '/get_suit_image';
  String userIdParam = "userId";
  String suitIdParam = "suitId";
  int userId;

  SuitPictureList({super.key, required this.userId});
}

class _SuitPictureListState extends State<SuitPictureList> {
  late List<Suit> _suitList;

  late List<String> images;

  void _showPictureDetail(
      BuildContext context, String imageUrl, Suit suit) {
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
        .map((Suit suit) => '$baseURL${widget.getSuitImageURL}'
            '?${widget.userIdParam}=${widget.userId}'
            '&${widget.suitIdParam}=${suit.suitId}')
        .toList();

    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns in the grid
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
        ),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print(index);
              _showPictureDetail(context, images[index], _suitList[index]);
              // ClothesDetailPage(imageUrl: images[index]);
              // _showForm(context, images[index]);
            },
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add button tap here
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
