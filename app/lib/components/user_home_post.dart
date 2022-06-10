import 'package:app/components/data_abstraction.dart';
import 'package:flutter/material.dart';

class UserHomePost extends StatefulWidget {
  final PostData postData;

  UserHomePost({
    Key? key,
    required this.postData,
  }) : super(key: key);

  @override
  _UserHomePost createState() => _UserHomePost();
}

class _UserHomePost extends State<UserHomePost> {
  @override
  Widget build(BuildContext context) {
    return Text("test");
  }
}
