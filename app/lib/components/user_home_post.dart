import 'dart:convert';
import 'package:app/cache.dart';
import 'package:app/components/data_abstraction.dart';
import 'package:app/global_variables.dart';
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
      return "ERROR";
    }
  }

  @override
  Widget build(BuildContext context) {
    /* Calculate how many sotck items to show */
    double freeHeight = MediaQuery.of(context).size.height -
        58 /* navbar height */ -
        56 /* card icon */ -
        48 /* post head */ -
        35 /* emoji count */ -
        30 /* emojis */ -
        60 /* Add comment button */ -
        26 /* self padding and margin */ -
        dialogHeight -
        dialogMargin * 2 /* dialog card and its margins */;

    int maxItemNum =
        (freeHeight ~/ (stockItemHeight + stockSeparatorHeight + 5)).toInt();

    return FutureBuilder<String>(
      future: _getPostData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData && snapshot.data != "ERROR") {
          debugPrint(snapshot.data);
          Map<String, dynamic> map = json.decode(snapshot.data!);
          // PostData pd = PostData.fromJson(snapshot.data!);
          // String author

          return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: freeHeight,
            child: const Center(
              child: Text("正在載入貼文..."),
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: freeHeight,
            child: const Center(
              child: Text("正在載入貼文..."),
            ),
          );
        }
      },
    );
  }
}
