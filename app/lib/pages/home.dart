

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState()=>_HomePageState();
}

class _HomePageState extends State<HomePage>{
  static const Widget _image = Image(image: AssetImage('assets/pic/hiyori.png'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:_image,
      ),
    );
  }

}