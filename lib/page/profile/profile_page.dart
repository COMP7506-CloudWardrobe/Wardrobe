import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/model/User.dart';
import 'package:wardrobe/store.dart';
import 'package:wardrobe/utils/color.dart';

import '../account/login_page.dart';
import 'collections_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _user;

  void _my_collections() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CollectionsPage(),
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _account_information() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<StoreProvider>(context, listen: false).user;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/login.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  '${_user.userName}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${_user.email}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _buildButton(context, 'My Collections', _my_collections),
                    _buildButton(
                        context, 'Account Settings', _account_information),
                    _buildButton(context, 'Log Out', _logout),
                    const SizedBox(height: 20),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
