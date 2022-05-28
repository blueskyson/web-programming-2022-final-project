import 'package:app/mock/post_2.dart';
import 'package:flutter/material.dart';
import 'package:app/global_variables.dart';

class ReadFullPost extends StatefulWidget {
  final Post post;
  const ReadFullPost({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _ReadFullPostState createState() => _ReadFullPostState();
}

class _ReadFullPostState extends State<ReadFullPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: navbarColor,
        title: const Text("貼文"),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: postLRMargin,
          right: postLRMargin,
          top: postLRMargin,
          bottom: postLRMargin,
        ),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: postBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
