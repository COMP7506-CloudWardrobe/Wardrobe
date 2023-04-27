import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/page/suit/suits_list.dart';

import '../../model/User.dart';
import '../../store.dart';


class SuitPage extends StatefulWidget {
  @override
  State<SuitPage> createState() => _SuitPageState();

  const SuitPage({super.key});
}

class _SuitPageState extends State<SuitPage> {
  late User _user;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<StoreProvider>(context, listen: false).user;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Outfits'),
        ),
        body: SuitPictureList(userId: _user.id));
  }
}
