import 'package:flutter/material.dart';

class CommentCard extends ListTile {
  final String author, avatarPath, message, timestamp;
  CommentCard({
    Key? key,
    required this.author,
    required this.avatarPath,
    required this.message,
    required this.timestamp,
  }) : super(
          key: key,
          leading: Image(
            image: AssetImage(avatarPath),
          ),
          title: Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            timestamp,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black87,
            ),
          ),
        );
}

List mockComments = [
  {
    'author': 'Chuks Okwuenu',
    'avatarPath': 'assets/mock/user1.png',
    'message': 'I love to code'
  },
  {
    'author': 'Biggi Man',
    'avatarPath': 'assets/mock/user2.png',
    'message': 'Very cool'
  },
  {
    'author': 'Tunde Martins',
    'avatarPath': 'assets/mock/user3.png',
    'message': 'Very cool'
  },
];
