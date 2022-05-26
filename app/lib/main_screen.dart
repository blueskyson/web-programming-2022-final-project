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
  List<BottomNavigationBarItem> _items = [];
  late TabController _tabController;
  late int _previousIndex;

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
      animationDuration: Duration(milliseconds: 100),
    );
    _previousIndex = 2;
  }

  static const List<Widget> _pages = <Widget>[
    SearchPage(),
    UserHomePage(),
    HomePage(),
    CommunityPage(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() => {
          if (!_tabController.indexIsChanging) {setState(() {})}
        });
    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomNavigationBar(
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black,
                currentIndex: _tabController.index,
                items: _items,
                onTap: (index) => setState(() {
                  _tabController.index = index;
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
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.5 - 35,
            width: 70,
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: IconButton(
                icon: Image.asset('assets/icon/logo2.png'),
                iconSize: 50,
                // animation
                onPressed: () => setState(() {
                  _tabController.index = 2;
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
