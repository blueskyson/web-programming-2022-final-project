import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _paddingAmount = 30.0;
    final _nameController = TextEditingController();
    final _passwordController = TextEditingController();
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.black,
      padding: EdgeInsets.all(0),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Placeholder(
            fallbackHeight: 70,
            color: Colors.transparent,
          ),
          const Image(
            height: 70,
            image: AssetImage("assets/icon/logo.png"),
          ),
          const Text(
            "股 市 女 友",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color.fromARGB(255, 97, 97, 97),
            ),
          ),
          const Text(
            "\"Sharing friends\' investing life through her!\"",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 197, 197, 197)),
          ),
          const Placeholder(
            fallbackHeight: 30,
            color: Colors.transparent,
          ),

          /* Input account */
          Container(
            padding: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
            ),
            child: const Text(
              "帳號名稱",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
            ),
            margin: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
              top: 10,
              bottom: 10,
            ),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextField(
              controller: _nameController,
              obscureText: false,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: '帳號名稱',
                border: InputBorder.none,
                hintStyle: TextStyle(height: 1.2),
              ),
            ),
          ),

          /* Input password */
          Container(
            padding: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
            ),
            child: const Text(
              "密碼",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
            ),
            margin: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
              top: 10,
              bottom: 10,
            ),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: '密碼',
                border: InputBorder.none,
                hintStyle: TextStyle(height: 1.2),
              ),
            ),
          ),

          /* log in button */
          Container(
            margin: const EdgeInsets.all(_paddingAmount),
            child: TextButton(
              style: _flatButtonStyle,
              child: const Text(
                "登入",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final body = jsonEncode({
                  'username': _nameController.text,
                  'password': _passwordController.text
                });
                final response = await http.post(
                    Uri.http("luffy.ee.ncku.edu.tw:8647", "/login"),
                    headers: {'Content-Type': 'application/json'},
                    body: body);

                debugPrint('${response.statusCode}');
                debugPrint('${response.body}');

                Navigator.popAndPushNamed(context, '/');
              },
            ),
          ),
        ],
      ),
    );
  }
}
