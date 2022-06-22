import 'dart:convert';
import 'dart:typed_data';
import 'package:app/cache.dart';
import 'package:app/components/data_abstraction.dart';
import 'package:app/components/post.dart';
import 'package:app/components/stock_line_chart.dart';
import 'package:app/global_variables.dart';
import 'package:app/pages/full_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class UserHomePost extends StatefulWidget {
  final String postID;

  const UserHomePost({
    Key? key,
    required this.postID,
  }) : super(key: key);

  @override
  _UserHomePost createState() => _UserHomePost();
}

class _UserHomePost extends State<UserHomePost> {
  Future<dynamic> _getPostData() async {
    final body = jsonEncode({
      "postid": widget.postID,
    });

    try {
      final response = await http.post(
        Uri.http("luffy.ee.ncku.edu.tw:8647", "/viewpost"),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      return response.bodyBytes;
    } catch (_) {
      return "ERROR";
    }
  }

  @override
  Widget build(BuildContext context) {
    /* Calculate how many sotck items to show */
    double freeHeight = MediaQuery.of(context).size.height -
        58 /* navbar height */ -
        56 /* card icon */ -
        48 /* post head */ -
        35 /* emoji count */ -
        30 /* emojis */ -
        60 /* Add comment button */ -
        26 /* self padding and margin */ -
        dialogHeight -
        dialogMargin * 2 /* dialog card and its margins */;

    int maxItemNum =
        (freeHeight ~/ (stockItemHeight + stockSeparatorHeight + 5)).toInt();

    return FutureBuilder<dynamic>(
      future: _getPostData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data != "ERROR") {
          List<Widget> stockItems = [];
          double listViewHeight = 0;
          Map<String, dynamic> map = jsonDecode(utf8.decode(snapshot.data!));

          if (map["stocklist"].length > maxItemNum) {
            freeHeight -= 30; /* for load more button */
            maxItemNum =
                (freeHeight ~/ (stockItemHeight + stockSeparatorHeight + 5))
                    .toInt();
          }

          double blankHeight =
              freeHeight % (stockItemHeight + stockSeparatorHeight + 5);
          List<dynamic> stockList = jsonDecode(map["stocklist"]);

          /* Create listview items */
          if (stockList.length > maxItemNum) {
            for (int i = 0; i < maxItemNum; i++) {
              stockItems.add(
                  StockLineChart(stockData: StockData.fromJsoon(stockList[i])));
            }

            /* Create load-more-button */
            Widget loadMoreButton = Container(
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(0),
                ),
                child: const Text(
                  "點擊載入更多",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {},
              ),
            );

            stockItems.add(loadMoreButton);
            listViewHeight =
                maxItemNum * (stockItemHeight + stockSeparatorHeight + 5) + 30;
          } else {
            for (int i = 0; i < stockList.length; i++) {
              stockItems.add(
                  StockLineChart(stockData: StockData.fromJsoon(stockList[i])));
            }
            listViewHeight =
                stockList.length * (stockItemHeight + stockSeparatorHeight + 5);
          }

          /* Count and sort emoji */
          Map<String, dynamic> emojiCounts = jsonDecode(map["emojicounts"]);
          int emojiSum = 0;
          for (int value in emojiCounts.values) {
            emojiSum += value;
          }
          final sortedEmojiCounts = Map.fromEntries(
            emojiCounts.entries.toList()
              ..sort((e1, e2) => e2.value.compareTo(e1.value)),
          );

          List<Widget> emojiItems = [];
          if (sortedEmojiCounts.length > 3) {
            for (int i = 0; i < 3; i++) {
              emojiItems.add(EmojiListItem(
                name: sortedEmojiCounts.keys.elementAt(i),
                count: sortedEmojiCounts.values.elementAt(i),
              ));
            }
            emojiItems.add(Text(
              "...+${sortedEmojiCounts.length - 3}",
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ));
          } else {
            for (String key in sortedEmojiCounts.keys) {
              emojiItems.add(
                  EmojiListItem(name: key, count: sortedEmojiCounts[key]!));
            }
          }

          return Container(
            margin: const EdgeInsets.only(
              left: postLRMargin,
              right: postLRMargin,
            ),
            padding: const EdgeInsets.all(3.0),
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

                  /* Use emoji */
                  leading: SvgPicture.asset(
                    "assets/icon/${emoji[map["moodid"]]}.svg",
                    height: 30.0,
                    width: 30.0,
                  ),
                  title: Text(
                    map["author"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    map["publishdate"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                    ),
                  ),
                ),

                /* Message */
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    left: postLRMargin,
                    right: postLRMargin,
                    bottom: postLRMargin,
                  ),
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    map["message"],
                    textAlign: TextAlign.left,
                  ),
                ),

                /* Stock cards */
                Container(
                  height: listViewHeight,
                  margin: EdgeInsets.only(
                    left: postLRMargin,
                    right: postLRMargin,
                    bottom: blankHeight,
                  ),
                  padding: const EdgeInsets.all(3.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListView.separated(
                    itemCount: stockItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return stockItems[index];
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.black,
                      height: stockSeparatorHeight,
                    ),
                  ),
                ),

                /* Emoji count */
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 30,
                    margin: const EdgeInsets.only(
                      left: postLRMargin,
                      right: postLRMargin,
                      top: 5.0,
                    ),
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "$emojiSum 個表情回應",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                /* Emoji list */
                Container(
                  height: 30,
                  margin: const EdgeInsets.only(
                    left: postLRMargin,
                    right: postLRMargin,
                  ),
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: emojiItems,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: freeHeight,
            child: const Center(
              child: Text("正在載入貼文..."),
            ),
          );
        }
      },
    );
  }
}
