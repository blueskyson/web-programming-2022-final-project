import 'package:flutter/material.dart';
import 'dart:ui';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<Widget> friendActList = [];
  void initState() {
    super.initState();

    friendActList = [FriendAct()];
  }

  @override
  Widget build(BuildContext context) {
    double parentWidth = MediaQuery.of(context).size.width;
    double parentHeight = MediaQuery.of(context).size.height;

    friendActList = [
      FriendAct(
        index: 0,
        screenWidth: parentWidth,
        screenHeight: parentHeight,
      )
    ];

    return Scaffold(
      body: Stack(children: friendActList),
    );
  }
}

class FriendAct extends Positioned {
  final String imagePath, message, timestamp;
  FriendAct(
      {Key? key,
      int index = 0,
      double screenWidth = 500,
      double screenHeight = 1000,
      this.imagePath = 'assets/pic/human.png',
      this.message = '',
      this.timestamp = '2022/01/01 9:30'})
      : super(
          key: key,
          left: screenWidth * 0.3,
          bottom: screenHeight * 0.5 - screenWidth * 0.75,
          child: Image(
            image: AssetImage(imagePath),
            width: screenWidth * 0.4,
            height: screenWidth * 0.4 * 2.5,
          ),
        );
}
