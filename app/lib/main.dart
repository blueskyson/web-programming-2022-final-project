import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'main_screen.dart';
import 'package:flutter/services.dart';
import 'package:app/mock/user_data.dart';

InAppLocalhostServer _lhs = InAppLocalhostServer(port: 9188);
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _lhs.start();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  UserData? user;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (isLogin) {
      return const MaterialApp(
        title: '理財女友',
        home: MainScreen(),
      );
    } else {
      return MaterialApp(
        title: '登入',
        home: LoginPage(),
      );
    }
  }
}
