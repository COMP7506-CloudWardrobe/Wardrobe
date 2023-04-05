import 'package:flutter/material.dart';
import 'clothes_detail.dart';

class PictureList extends StatelessWidget {
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
    'https://picsum.photos/id/113/250/250',
  ];

  void _showPictureDetail(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClothesDetailPage(imageUrl: imageUrl),
      ),
    );
  }

  void _showForm(BuildContext context, String imageUrl) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Enter your information'),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Submit form data here
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
