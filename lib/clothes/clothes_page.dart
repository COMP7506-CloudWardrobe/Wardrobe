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

  List<Widget> _widgetOptions = <Widget>[
    PictureList(),
    PictureList(),
    PictureList(),
    PictureList()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothes'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleSideNav,
        ),
      ),
      body: Row(
        children: <Widget>[
          if (_isSideNavOpen)
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                width: _isSideNavOpen ? 200.0 : 0.0,
                child: Drawer(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text('Tops'),
                        onTap: () {
                          _onItemTapped(0);
                          _toggleSideNav();
                        },
                        selected: _selectedIndex == 0,
                      ),
                      ListTile(
                        title: Text('Bottoms'),
                        onTap: () {
                          _onItemTapped(1);
                          _toggleSideNav();
                        },
                        selected: _selectedIndex == 1,
                      ),
                      ListTile(
                        title: Text('One-piece'),
                        onTap: () {
                          _onItemTapped(2);
                          _toggleSideNav();
                        },
                        selected: _selectedIndex == 2,
                      ),
                      ListTile(
                        title: Text('Accessory'),
                        onTap: () {
                          _onItemTapped(3);
                          _toggleSideNav();
                        },
                        selected: _selectedIndex == 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}
