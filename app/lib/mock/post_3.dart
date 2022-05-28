import 'package:app/mock/post_2.dart';
import 'package:flutter/material.dart';
import 'package:app/global_variables.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReadFullPost extends StatefulWidget {
  final Post post;
  late String avatarPath;
  late String emojiPath;
  late String author;
  late List<Widget> stocks;
  late Map<String, int> emojiCounts;
  late String title;
  late String subtitle;
  late String publishDate;

  ReadFullPost({
    Key? key,
    required this.post,
  }) : super(key: key) {
    avatarPath = post.avatarPath;
    emojiPath = post.emojiPath;
    author = post.author;
    stocks = post.stocks;
    emojiCounts = post.emojiCounts;
    title = post.title;
    subtitle = post.subtitle;
    publishDate = post.publishDate;
  }

  @override
  _ReadFullPostState createState() => _ReadFullPostState();
}

class _ReadFullPostState extends State<ReadFullPost> {
  @override
  Widget build(BuildContext context) {
    double listViewHeight =
        widget.stocks.length * (stockItemHeight + stockSeparatorHeight + 5);
    double fullPostHeight = listViewHeight +
        40 +
        10 * 2 /* post head and margin */ +
        postLRMargin /* bottom margin */;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: navbarColor,
        title: const Text("貼文"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: fullPostHeight,
          margin: const EdgeInsets.only(
            left: postLRMargin,
            right: postLRMargin,
            top: postLRMargin,
            bottom: postLRMargin,
          ),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: postBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: <Widget>[
              /* Post head */
              ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: postLRMargin,
                  vertical: 0.0,
                ),

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
                    fontSize: 16,
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

              /* Stock cards */
              Container(
                height: listViewHeight,
                margin: const EdgeInsets.only(
                  left: postLRMargin,
                  right: postLRMargin,
                ),
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.stocks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widget.stocks[index];
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    color: Colors.black,
                    height: stockSeparatorHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
