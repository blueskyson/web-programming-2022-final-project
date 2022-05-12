import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:csv/csv.dart';

const double stockItemHeight = 70.0;

/* Stock object */
class StockLineChart extends StatelessWidget {
  final int num;
  final String startDate;
  final String endDate;
  final int holding;
  const StockLineChart({
    Key? key,
    required this.num,
    required this.startDate,
    required this.endDate,
    required this.holding,
  }) : super(key: key);

  Future<String> _drawChart() async {
    return await rootBundle.loadString("assets/csv/${num}_history.csv");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _drawChart(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          /* Get stock data */
          List<List<dynamic>> csvTable =
              const CsvToListConverter().convert(snapshot.data);
          List<FlSpot> dataPoints = [];
          for (int i = csvTable.length - 51, j = 0;
              i < csvTable.length - 1;
              i++, j++) {
            dataPoints.add(FlSpot(j.toDouble(), double.parse(csvTable[i][4])));
          }

          /* Compute price difference */
          double ratio;
          try {
            ratio = (dataPoints.last.y / dataPoints.first.y) - 1;
          } on Exception {
            ratio = 0;
          }
          int percentage = (ratio * 100).round();
          double diff = dataPoints.last.y - dataPoints.first.y;
          int diffAmount = (holding * diff).round().abs();
          String placeholder = diff > 0 ? "賺" : "賠";
          String diffAmuntString = diffAmount > 10000
              ? "${(diffAmount / 10000).round()} 萬"
              : "$diffAmount";

          /* Line chart style */
          Color lineColor = diff > 0
              ? const Color.fromARGB(255, 255, 77, 65)
              : const Color.fromARGB(255, 63, 255, 69);
          Color sellContainerColor = diff > 0
              ? const Color.fromARGB(255, 255, 223, 221)
              : const Color.fromARGB(255, 228, 255, 229);
          /* Range of close price */
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    height: stockItemHeight,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: LineChart(
                      LineChartData(
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: dataPoints,
                            isCurved: true,
                            barWidth: 0,
                            color: lineColor,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[lineColor, Colors.white],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    // draw a red marble
                    top: 0.0,
                    left: 0.0,
                    child: Text(
                      "$num",
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "($percentage%) $placeholder NT $diffAmuntString",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: lineColor,
                      fontSize: 17,
                    ),
                  ),
                  const Placeholder(
                    fallbackHeight: 5,
                    fallbackWidth: 10,
                    color: Colors.transparent,
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(3.0),
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          "買入\n${dataPoints.first.y.toStringAsFixed(2)}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(3.0),
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: sellContainerColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Text(
                          "賣出\n${dataPoints.last.y.toStringAsFixed(2)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: lineColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        } else {
          return const SizedBox(
            width: stockItemHeight,
            height: stockItemHeight,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

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
  final Map<String, int> emojiCounts;
  final String title;
  final String subtitle;
  final String publishDate;
  const Post({
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
    /* Create listview items */
    List<Widget> stockItems = [];
    double listViewHeight = 0;
    if (widget.stocks.length > 3) {
      stockItems = [
        widget.stocks[0],
        widget.stocks[1],
        widget.stocks[2],
        const Text(
          "下滑載入更多",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ];
      listViewHeight = 3 * (stockItemHeight + 10) + 30;
    } else {
      stockItems = widget.stocks;
      listViewHeight = widget.stocks.length * (stockItemHeight + 20);
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

    return Column(
      children: <Widget>[
        /* Post head */
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
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
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            border: Border.all(color: Colors.black),
          ),
          child: ListView.separated(
            itemCount: stockItems.length,
            itemBuilder: (BuildContext context, int index) {
              return stockItems[index];
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.black,
              height: 5,
            ),
          ),
        ),

        /* Emoji count */
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0),
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
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: emojiItems,
          ),
        ),

        /* Add comment */
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(color: Colors.grey),
              ),
              child: const Text(
                "新增表情",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: const Text(
                "新增留言",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),

        /* Dialog */
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 140,
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
                        "${widget.author}說: ${widget.title}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/* Mock posts */
List<Widget> mockPosts = [
  const Post(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_astonished-face.svg",
    author: '吃到辣椒的吉娃娃',
    stocks: [
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
  const Post(
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
