import 'package:flutter/material.dart';
import 'package:app/mock/post_2.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    double parentWidth = MediaQuery.of(context).size.width;
    double parentHeight = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[mockPosts[0]],
    );
  }
}
