import 'package:app/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'main_screen.dart';
import 'package:flutter/services.dart';
import 'package:app/global_variables.dart';

InAppLocalhostServer _lhs = InAppLocalhostServer(port: 9188);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: navbarColor, // status bar color
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await _lhs.start();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _isLogin = true;
  @override
  Widget build(BuildContext context) {
    String _initRoute;
    if (_isLogin) {
      _initRoute = '/';
    } else {
      _initRoute = '/login';
    }
    return MaterialApp(
      initialRoute: _initRoute,
      routes: {
        '/': (context) => const MainScreen(),
        '/login': (context) => const LoginPage(),
      },
      title: '理財女友',
      debugShowCheckedModeBanner: false,
    );
  }
}
