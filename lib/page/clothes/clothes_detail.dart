import 'package:flutter/material.dart';
import 'clothes_page.dart';

class ClothesDetailPage extends StatefulWidget {
  final String imageUrl;

  const ClothesDetailPage({super.key, required this.imageUrl});

  @override
  State<ClothesDetailPage> createState() => _ClothesDetailPageState();
}

class _ClothesDetailPageState extends State<ClothesDetailPage> {
  int _modified = 0;
  final List<String> _buttonLabels = ["Modify", "Submit"];

  void _toggleModify() {
    setState(() {
      _modified = (_modified + 1) % 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picture Detail'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Enter your information',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      _toggleModify();
                    },
                    child: Text(_buttonLabels[_modified]),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
