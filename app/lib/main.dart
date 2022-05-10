import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'main_screen.dart';
import 'package:flutter/services.dart';

InAppLocalhostServer _lhs = InAppLocalhostServer(port: 9188);
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await _lhs.start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      title: '虛擬理財女友',
      home: MainScreen(),
    );
  }
}
