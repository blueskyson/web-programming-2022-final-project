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
    UserHomePage(),
    HomePage(),
    CommunityPage(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Color navbarColor = const Color.fromARGB(255, 234, 234, 234);
    return GestureDetector(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomNavigationBar(
                  backgroundColor: Colors.blue,
                  selectedItemColor: Colors.amber,
                  unselectedItemColor: Colors.black,
                  currentIndex: _selectedIndex,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.search),
                      label: '搜尋',
                      backgroundColor: navbarColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.fromString('account')),
                      label: '個人主頁',
                      backgroundColor: navbarColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.fromString('')),
                      label: '',
                      backgroundColor: navbarColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.fromString('finance')),
                      label: '社群',
                      backgroundColor: navbarColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.fromString('chat-processing')),
                      label: '通知',
                      backgroundColor: navbarColor,
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      // go to search page
                      if (index == 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SearchPage()));
                        return;
                      }
                      _selectedIndex = index;
                    });
                  },
                ),
                Expanded(
                  child: Material(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.4,
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: IconButton(
                  icon: Image.asset('assets/icon/logo2.png'),
                  iconSize: MediaQuery.of(context).size.width * 0.15,
                  // animation
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      onHorizontalDragEnd: (d) => setState(() {
        if (_selectedIndex == 2) return;
        if (d.primaryVelocity! > 0) {
          _selectedIndex =
              (_selectedIndex - 1) % 5 == 0 ? 4 : (_selectedIndex - 1) % 5;
        }
        if (d.primaryVelocity! < 0) {
          _selectedIndex =
              (_selectedIndex + 1) % 5 == 0 ? 1 : (_selectedIndex + 1) % 5;
        }
      }),
    );
  }
}
