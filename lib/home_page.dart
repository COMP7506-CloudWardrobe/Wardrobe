import 'package:flutter/material.dart';
import 'package:wardrobe/model/ClothesWardrobe.dart';
import 'model/User.dart';
import '../page/clothes/clothes_page.dart';
import '../page/suit/suit_page.dart';
import '../page/insight/insight_page.dart';
import '../page/profile/profile_page.dart';
import 'package:wardrobe/dao/clothes_dao.dart';
import 'package:wardrobe/store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      ClothesPage(),
      SuitPage(userId: widget.user.id),
      InsightPage(),
      ProfilePage(),
    ];
    // 构建衣橱
    // ClothesDao.getAllClothes(
    //         Provider.of<StoreProvider>(context, listen: false).user.id)
    //     .then((clothesWardrobe) {
    //   Provider.of<StoreProvider>(context, listen: false)
    //       .setClothesWardrobe(clothesWardrobe);
    //
    //   _widgetOptions = <Widget>[
    //     ClothesPage(),
    //     SuitPage(),
    //     InsightPage(),
    //     ProfilePage(),
    //   ];
    // });

    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Clothes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Suit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Insight',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
