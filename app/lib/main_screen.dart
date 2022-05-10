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

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: You shouldn\'t see this'),
    NotificationPage(),
    HomePage(),
    CommunityPage(),
    UserHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.black,
              currentIndex: _selectedIndex,
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SearchPage()));
                    return;
                  }
                  _selectedIndex = index;
                });
              }),
          Expanded(
              child: Scaffold(
            body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
          ))
        ],
      )),
      onHorizontalDragEnd: (d) => setState(() {
        if (d.primaryVelocity! > 0) {
          _selectedIndex =
              (_selectedIndex + 1) % 5 == 0 ? 1 : (_selectedIndex + 1) % 5;
        }
        if (d.primaryVelocity! < 0) {
          _selectedIndex =
              (_selectedIndex - 1) % 5 == 0 ? 4 : (_selectedIndex - 1) % 5;
        }
      }),
    );
  }
}
