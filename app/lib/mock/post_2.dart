import 'package:app/pages/full_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/global_variables.dart';
import 'package:app/components/stock_line_chart.dart';

/* Emoji object */
class EmojiListItem extends StatelessWidget {
  final String name;
  final int count;
  const EmojiListItem({
    Key? key,
    required this.name,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: SvgPicture.asset(
              "assets/icon/$name.svg",
              height: 20.0,
              width: 20.0,
            ),
          ),
          WidgetSpan(
            child: Text(
              " ${count.toString().padRight(13, ' ')}",
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

/* Post object */
class Post extends StatefulWidget {
  final String avatarPath;
  final String emojiPath;
  final String author;
  final List<Widget> stocks;
  Map<String, int> emojiCounts;
  final String title;
  final String subtitle;
  final String publishDate;
  Post({
    Key? key,
    required this.avatarPath,
    required this.emojiPath,
    required this.author,
    required this.stocks,
    required this.emojiCounts,
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
    List<Widget> stockItems = [];
    double listViewHeight = 0;

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

    if (widget.stocks.length > maxItemNum) {
      freeHeight -= 30; /* for load more button */
      maxItemNum =
          (freeHeight ~/ (stockItemHeight + stockSeparatorHeight + 5)).toInt();
    }

    double blankHeight =
        freeHeight % (stockItemHeight + stockSeparatorHeight + 5);

    /* Create listview items */
    if (widget.stocks.length > maxItemNum) {
      for (int i = 0; i < maxItemNum; i++) {
        stockItems.add(widget.stocks[i]);
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FullPostPage(post: widget),
              ),
            );
          },
        ),
      );

      stockItems.add(loadMoreButton);
      listViewHeight =
          maxItemNum * (stockItemHeight + stockSeparatorHeight + 5) + 30;
    } else {
      stockItems = widget.stocks;
      listViewHeight =
          widget.stocks.length * (stockItemHeight + stockSeparatorHeight + 5);
    }

    /* Count and sort emoji */
    int emojiSum = 0;
    for (int value in widget.emojiCounts.values) {
      emojiSum += value;
    }
    final sortedEmojiCounts = Map.fromEntries(
      widget.emojiCounts.entries.toList()
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
        emojiItems
            .add(EmojiListItem(name: key, count: sortedEmojiCounts[key]!));
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: postLRMargin, right: postLRMargin),
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
  }
}

/* Mock posts */
List<Post> mockPosts = [
  Post(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_astonished-face.svg",
    author: '吃到辣椒的吉娃娃',
    stocks: const <Widget>[
      StockLineChart(
        num: 2330,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 10000,
      ),
      StockLineChart(
        num: 2603,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 2000,
      ),
      StockLineChart(
        num: 2002,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 300,
      ),
      StockLineChart(
        num: 2454,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockLineChart(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockLineChart(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockLineChart(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockLineChart(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockLineChart(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockLineChart(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
    ],
    emojiCounts: {
      "twemoji_confounded-face": 6,
      "twemoji_angry-face": 5,
      "twemoji_anguished-face": 1,
      "twemoji_cowboy-hat-face": 10,
      "twemoji_anxious-face-with-sweat": 1,
      "twemoji_astonished-face": 1,
      "twemoji_beaming-face-with-smiling-eyes": 1,
    },
    title: '跟破壞性科技相比，基金管理人就是遜啦',
    subtitle: '我的100行的Python腳本平均收益都比較高',
    publishDate: '5月11日',
  ),
  Post(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_beaming-face-with-smiling-eyes.svg",
    author: '後空翻的猿人',
    stocks: [],
    emojiCounts: {},
    title: '第一次0DTE就上手',
    subtitle: '散戶們，衝啊',
    publishDate: '2月26日',
  ),
];
