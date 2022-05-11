import 'package:flutter/material.dart';
import 'package:app/mock/post_2.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _currentPostIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[mockPosts[_currentPostIndex]],
    );
  }
}
