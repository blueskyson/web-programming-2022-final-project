import 'dart:convert';
import 'package:app/components/data_abstraction.dart';
import 'package:app/mock/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<dynamic> postHistory = <dynamic>[];
List<Widget> userHomePosts = <Widget>[];

void updatePostHistory() async {
  final body = jsonEncode({
    "username": mockUser.account,
  });

  try {
    final response = await http.post(
      Uri.http("luffy.ee.ncku.edu.tw:8647", "/view"),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    final Map parsed = json.decode(response.body);
    postHistory = parsed["history"];
  } catch (_) {}
}
