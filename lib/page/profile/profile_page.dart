import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/model/User.dart';
import 'package:wardrobe/store.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // _requestPermissions();
    _selectedImage = null;
  }

  Future<void> _selectImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      print('Permission granted');
    } else if (status.isDenied) {
      print('Permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Permission permanently denied');
      bool isOpened = await openAppSettings();
      print('App Settings opened: ' + isOpened.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_selectedImage != null) Image.file(_selectedImage!),
          ElevatedButton(
            onPressed: _selectImage,
            child: Text('Select Image'),
          ),
        ],
      ),
    );
  }
}

