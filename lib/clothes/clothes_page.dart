import 'package:flutter/material.dart';
import 'clothes_list.dart';

class ClothesPage extends StatefulWidget {
  // const ClothesPage({super.key});

  @override
  State<ClothesPage> createState() => _ClothesPageState();
}

class _ClothesPageState extends State<ClothesPage> {
  int _selectedIndex = 0;
  bool _isSideNavOpen = false;
  final List<String> _clothesCategory = [
    "Tops",
    "Bottoms",
    "One-piece",
    "Shoes",
    "Accessory"
  ];

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

  final List<Widget> _widgetOptions = <Widget>[
    ClothesPictureList(),
    ClothesPictureList(),
    ClothesPictureList(),
    ClothesPictureList(),
    ClothesPictureList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_clothesCategory[_selectedIndex]),
        leading: IconButton(
          icon: Icon(Icons.menu),
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
