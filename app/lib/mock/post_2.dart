import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Post extends StatefulWidget {
  final String avatarPath;
  final String emojiPath;
  final String author;
  final String imagePath;
  final String title;
  final String subtitle;
  final String publishDate;

  const Post({
    Key? key,
    required this.avatarPath,
    required this.emojiPath,
    required this.author,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.publishDate,
  }) : super(key: key);
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: <Widget>[
          /* Post head */
          ListTile(
            /* Use avatar */
            // leading: CircleAvatar(
            //   backgroundColor: Colors.transparent,
            //   backgroundImage: AssetImage(widget.avatarPath),
            // ),
            /* Use emoji */
            leading: SvgPicture.asset(
              widget.emojiPath,
              height: 30.0,
              width: 30.0,
            ),
            title: Text(
              widget.author,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              widget.publishDate,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 11,
              ),
            ),
          ),

          /* Post body */
        ],
      ),
    );
  }
}

const List<Widget> mockPosts = [
  Post(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_anxious-face-with-sweat.svg",
    author: '吃到辣椒的吉娃娃',
    imagePath: 'assets/mock/meme2.jpg',
    title: '跟破壞性科技相比，基金管理人就是遜啦',
    subtitle: '我的100行的Python腳本平均收益都比較高',
    publishDate: '12月28日',
  ),
  Post(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_beaming-face-with-smiling-eyes.svg",
    author: '後空翻的猿人',
    imagePath: 'assets/mock/meme3.jpg',
    title: '第一次0DTE就上手',
    subtitle: '散戶們，衝啊',
    publishDate: '2月26日',
  ),
];
