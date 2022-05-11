import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    double postHeight = 100;
    if (imagePath != '') {
      postHeight += MediaQuery.of(context).size.width;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: SizedBox(
        height: postHeight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(imagePath),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    publishDate,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<Widget> mockPosts = [
  Post(
    imagePath: 'assets/mock/meme2.jpg',
    title: '跟破壞性科技相比，基金管理人就是遜啦',
    subtitle: '我的100行的Python腳本平均收益都比較高',
    author: '吃到辣椒的吉娃娃',
    publishDate: '12月28日',
    readDuration: '5分鐘前',
  ),
  Post(
    imagePath: 'assets/mock/meme3.jpg',
    title: '第一次0DTE就上手',
    subtitle: '散戶們，衝啊',
    author: '後空翻的猿人',
    publishDate: '2月26日',
    readDuration: '12分鐘前',
  ),
];
