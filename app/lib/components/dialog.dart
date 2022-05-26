import 'package:flutter/material.dart';
import 'package:app/global_variables.dart';

class TextDialog extends StatelessWidget {
  final String message;

  const TextDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dialogHeight,
      margin: const EdgeInsets.all(dialogMargin),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 232, 232, 232),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(dialogMargin),
              padding: const EdgeInsets.all(3.0),
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarDialog extends StatelessWidget {
  final String message;

  const AvatarDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dialogHeight,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 232, 232, 232),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Image(
            image: AssetImage("assets/pic/hiyori_avatar.png"),
            height: 140.0,
            width: 100.0,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
