import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Widget _image =
      Image(image: AssetImage('assets/pic/hiyori.png'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 800.0,
        width: 500.0,
        padding: const EdgeInsets.only(top: 150, bottom: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
        ),
        child: const Center(
          child: _image,
        ),
      ),
    );
  }
}
