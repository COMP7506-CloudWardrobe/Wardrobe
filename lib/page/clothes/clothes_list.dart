import 'package:flutter/material.dart';
import 'clothes_detail.dart';

class ClothesPictureList extends StatelessWidget {
  final List<String> images = [
    'https://picsum.photos/id/1018/250/250',
    'https://picsum.photos/id/1025/250/250',
    'https://picsum.photos/id/1041/250/250',
    'https://picsum.photos/id/1050/250/250',
    'https://picsum.photos/id/1060/250/250',
    'https://picsum.photos/id/1074/250/250',
    'https://picsum.photos/id/1080/250/250',
    'https://picsum.photos/id/109/250/250',
    'https://picsum.photos/id/110/250/250',
    'https://picsum.photos/id/111/250/250',
    'https://picsum.photos/id/112/250/250',
    'http://localhost:8080/get_clothes_image?userId=1&clothesId=8',
  ];

  void _showPictureDetail(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClothesDetailPage(imageUrl: imageUrl),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
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
              _showPictureDetail(context, images[index]);
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
