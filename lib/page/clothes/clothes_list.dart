import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/Clothes.dart';
import '../../store.dart';
import '../../utils/url.dart';
import 'clothes_detail.dart';

class ClothesPictureList extends StatefulWidget {
  @override
  State<ClothesPictureList> createState() => _ClothesPictureListState();

  String getClothesImageURL = '/get_clothes_image';

  String userIdParam = 'userId';

  String clothesIdParam = 'clothesId';

  int clothesType;

  int userId;

  ClothesPictureList(
      {super.key, required this.clothesType, required this.userId});
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

  @override
  Widget build(BuildContext context) {
    _clothesList = Provider.of<StoreProvider>(context, listen: true)
        .getClothesList(widget.clothesType)!;

    images = _clothesList
        .map((Clothes clothes) => '$baseURL${widget.getClothesImageURL}'
            '?${widget.userIdParam}=${widget.userId}'
            '&${widget.clothesIdParam}=${clothes.id}')
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
              _showPictureDetail(context, images[index], _clothesList[index]);
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
