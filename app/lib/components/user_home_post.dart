import 'dart:convert';
import 'package:app/components/data_abstraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UserHomePost extends StatefulWidget {
  final String postID;

  const UserHomePost({
    Key? key,
    required this.postID,
  }) : super(key: key);

  @override
  _UserHomePost createState() => _UserHomePost();
}

class _UserHomePost extends State<UserHomePost> {
  Future<String> _getPostData() async {
    final body = jsonEncode({
      "postid": widget.postID,
    });

    try {
      final response = await http.post(
        Uri.http("luffy.ee.ncku.edu.tw:8647", "/viewpost"),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      return response.body;
    } catch (_) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getPostData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data);
          return const Placeholder(
            fallbackHeight: 50,
            color: Colors.blue,
          );
        } else {
          return const Placeholder(
            fallbackHeight: 50,
            color: Colors.black,
          );
        }
      },
    );
  }
}
