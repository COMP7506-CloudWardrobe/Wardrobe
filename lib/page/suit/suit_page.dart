import 'package:flutter/material.dart';
import 'package:wardrobe/page/suit/suits_list.dart';


class SuitPage extends StatefulWidget {
  @override
  State<SuitPage> createState() => _SuitPageState();

  int userId;

  SuitPage({super.key, required this.userId});
}

class _SuitPageState extends State<SuitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Suits'),
        ),
        body: SuitPictureList(userId: widget.userId));
  }
}
