import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/model/User.dart';
import 'package:wardrobe/store.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StoreProvider>(context);
    final user = provider.user;
    String userId = user!.id.toString();

    return Center(
      child: Text("UserId is " + userId),
    );
  }
}

