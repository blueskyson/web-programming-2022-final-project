import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color messageColor = Colors.transparent;
  String message = "登入成功";

  @override
  Widget build(BuildContext context) {
    const double _paddingAmount = 30.0;
    final _nameController = TextEditingController();
    final _passwordController = TextEditingController();

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
            "\"Sharing friends' investing life through her!\"",
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

          /* Login message */
          Container(
            padding: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
            ),
            child: Text(
              message,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                color: messageColor,
              ),
            ),
          ),

          /* log in button */
          Container(
            margin: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.all(0),
              ),
              child: const Text(
                "登入",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final body = jsonEncode({
                  'username': _nameController.text,
                  'pwhash': _passwordController.text
                });

                try {
                  final response = await http.post(
                      Uri.http("luffy.ee.ncku.edu.tw:8647", "/login"),
                      headers: {'Content-Type': 'application/json'},
                      body: body);
                  // Success login
                  if (response.statusCode == 200) {
                    setState(() {
                      messageColor = Colors.green;
                      message = "登入成功";
                    });
                    Navigator.popAndPushNamed(context, '/');
                  }
                  // Error login
                  else {
                    setState(() {
                      messageColor = Colors.red;
                      message = "帳號或密碼錯誤";
                    });
                  }
                } catch (e) {
                  setState(() {
                    messageColor = Colors.red;
                    message = "網路錯誤";
                  });
                }
              },
            ),
          ),

          /* register button */
          Container(
            margin: const EdgeInsets.only(
              left: _paddingAmount,
              right: _paddingAmount,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(0),
                side: const BorderSide(width: 1, color: Colors.black),
              ),
              child: const Text(
                "註冊",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                final body = jsonEncode({
                  'username': _nameController.text,
                  'pwhash': _passwordController.text
                });

                try {
                  final response = await http.post(
                      Uri.http("luffy.ee.ncku.edu.tw:8647", "/reg"),
                      headers: {'Content-Type': 'application/json'},
                      body: body);

                  // Success login
                  if (response.statusCode == 200) {
                    setState(() {
                      messageColor = Colors.green;
                      message = "註冊成功";
                    });
                    // Navigator.popAndPushNamed(context, '/');
                  }
                  // Error login
                  else {
                    setState(() {
                      messageColor = Colors.red;
                      message = response.body;
                    });
                  }
                } catch (e) {
                  setState(() {
                    messageColor = Colors.red;
                    message = "網路錯誤";
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
