import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/model/ClothesWardrobe.dart';
import 'package:wardrobe/store.dart';
import '../../model/User.dart';
import 'clothes_list.dart';

class ClothesPage extends StatefulWidget {
  const ClothesPage({super.key});

  @override
  State<ClothesPage> createState() => _ClothesPageState();
}

class _ClothesPageState extends State<ClothesPage> {

  int _selectedIndex = 0;

  bool _isSideNavOpen = false;

  // late ClothesWardrobe _wardrobe;

  late User _user;

  late List<Widget> _widgetOptions;

  final List<String> _clothesCategory = [
    "Tops",
    "Bottoms",
    "Outwears",
    "Shoes",
    "Accessories"
  ];

  @override
  void initState() {
    super.initState();
    // _requestPermissions();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleSideNav() {
    setState(() {
      _isSideNavOpen = !_isSideNavOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<StoreProvider>(context, listen: false).user;

    _widgetOptions = [
      ClothesPictureList(clothesType: 0, userId: _user.id, selectedIndex: _selectedIndex),
      ClothesPictureList(clothesType: 1, userId: _user.id, selectedIndex: _selectedIndex),
      ClothesPictureList(clothesType: 2, userId: _user.id, selectedIndex: _selectedIndex),
      ClothesPictureList(clothesType: 3, userId: _user.id, selectedIndex: _selectedIndex),
      ClothesPictureList(clothesType: 4, userId: _user.id, selectedIndex: _selectedIndex)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_clothesCategory[_selectedIndex]),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _toggleSideNav,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          if (_isSideNavOpen)
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 150, // 设置父部件的最大宽度
                maxHeight: 300, // 设置父部件的最大高度
              ),
              child: Drawer(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(_clothesCategory[0]),
                      onTap: () {
                        _onItemTapped(0);
                        _toggleSideNav();
                      },
                      selected: _selectedIndex == 0,
                    ),
                    ListTile(
                      title: Text(_clothesCategory[1]),
                      onTap: () {
                        _onItemTapped(1);
                        _toggleSideNav();
                      },
                      selected: _selectedIndex == 1,
                    ),
                    ListTile(
                      title: Text(_clothesCategory[2]),
                      onTap: () {
                        _onItemTapped(2);
                        _toggleSideNav();
                      },
                      selected: _selectedIndex == 2,
                    ),
                    ListTile(
                      title: Text(_clothesCategory[3]),
                      onTap: () {
                        _onItemTapped(3);
                        _toggleSideNav();
                      },
                      selected: _selectedIndex == 3,
                    ),
                    ListTile(
                      title: Text(_clothesCategory[4]),
                      onTap: () {
                        _onItemTapped(4);
                        _toggleSideNav();
                      },
                      selected: _selectedIndex == 4,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
