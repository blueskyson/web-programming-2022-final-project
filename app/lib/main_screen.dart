import 'package:app/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app/pages/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: You shouldn\'t see this',
      style: optionStyle,
    ),
    Text(
      'Index 1: Chat',
      style: optionStyle,
    ),
    HomePage(),
    Text(
      'Index 3: Stock',
      style: optionStyle,
    ),
    Text(
      'Index 4: Account',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Management GF'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('chat-processing')),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('home')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('finance')),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('account')),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          setState(() {
            // go to search page
            if (index == 0) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage()));
              return;
            }
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
