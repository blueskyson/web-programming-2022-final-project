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

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  List<BottomNavigationBarItem> _items = [];
  late TabController _tabController;

  _MainScreenState() {
    Color _navbarColor = const Color.fromARGB(255, 234, 234, 234);
    _items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.search),
        label: '搜尋',
        backgroundColor: _navbarColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(MdiIcons.fromString('account')),
        label: '個人主頁',
        backgroundColor: _navbarColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(MdiIcons.fromString('')),
        label: '',
        backgroundColor: _navbarColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(MdiIcons.fromString('finance')),
        label: '社群',
        backgroundColor: _navbarColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(MdiIcons.fromString('chat-processing')),
        label: '通知',
        backgroundColor: _navbarColor,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: _items.length,
      initialIndex: 2,
    );
  }

  static const List<Widget> _pages = <Widget>[
    Text("0"),
    UserHomePage(),
    HomePage(),
    CommunityPage(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              animationDuration: const Duration(microseconds: 200),
              length: _items.length,
              child: Builder(builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BottomNavigationBar(
                      selectedItemColor: Colors.blue,
                      unselectedItemColor: Colors.black,
                      currentIndex: _selectedIndex,
                      items: _items,
                      onTap: (index) => setState(() {
                        // go to search page
                        if (index == 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SearchPage(),
                          ));
                          return;
                        }
                        _selectedIndex = index;
                        _tabController.index = _selectedIndex;
                      }),
                    ),
                    Expanded(
                      child: Material(
                        child: TabBarView(
                          controller: _tabController,
                          children: _pages,
                        ),
                      ),
                    ),
                  ],
                );
              }),
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
                  onPressed: () => setState(() {
                    _selectedIndex = 2;
                  }),
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
        debugPrint("hello");
      }),
    );
  }
}
