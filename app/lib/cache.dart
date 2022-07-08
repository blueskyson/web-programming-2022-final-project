import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/mock/user.dart';
import 'package:flutter/material.dart';

List<dynamic> postHistory = <dynamic>[];
List<Widget> userHomePosts = <Widget>[];

Future<String> getPostHistory() async {
  final body = jsonEncode({
    "username": mockUser.account,
  });

  try {
    final response = await http.post(
      Uri.http("luffy.ee.ncku.edu.tw:8647", "/view"),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    debugPrint(response.body);
    if (response.body == "") {
      return "EMPTY";
    }
    final Map parsed = json.decode(response.body);
    postHistory = parsed["history"];
    return "OK";
  } catch (_) {
    return "ERROR";
  }
}
