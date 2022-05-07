import 'package:app/pages/notification.dart';
import 'package:app/pages/user_home.dart';
import 'package:app/pages/search.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/community.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    Text('Index 0: You shouldn\'t see this'),
    NotificationPage(),
    HomePage(),
    CommunityPage(),
    UserHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('虛擬理財女友'),
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
            label: '搜尋',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('chat-processing')),
            label: '通知',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('home')),
            label: '首頁',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('finance')),
            label: '社群',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('account')),
            label: '個人主頁',
          ),
        ],
        onTap: (index) {
          setState(() {
            // go to search page
            if (index == 0) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage()));
              return;
            }
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
