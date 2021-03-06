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
    title: '??????????????????????????????????????????????????????',
    subtitle: '??????100??????Python??????????????????????????????',
    author: '????????????????????????',
    publishDate: '12???28???',
    readDuration: '5?????????',
  ),
  Post(
    imagePath: 'assets/mock/meme3.jpg',
    title: '?????????0DTE?????????',
    subtitle: '??????????????????',
    author: '??????????????????',
    publishDate: '2???26???',
    readDuration: '12?????????',
  ),
];
