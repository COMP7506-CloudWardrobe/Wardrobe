import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/Suit.dart';
import '../../store.dart';

class SuitDetailPage extends StatefulWidget {
  final String imageUrl;
  final Suit suit;
  final int userId;

  const SuitDetailPage(
      {super.key,
      required this.imageUrl,
      required this.suit,
      required this.userId});

  @override
  State<SuitDetailPage> createState() => _SuitDetailPageState();
}

class _SuitDetailPageState extends State<SuitDetailPage> {
  int _modified = 0;
  final List<String> _buttonLabels = ["Modify", "Delete"];

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
                      if (_modified == 1) {
                        print("delete");
                        // Provider.of<StoreProvider>(context, listen: false)
                        //     .deleteClothes(widget.suit);
                        // ClothesDao.deleteClothes(
                        //     widget.userId, widget.clothes.id);
                        Navigator.pop(context);
                      }
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
