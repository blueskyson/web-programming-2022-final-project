import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app/mock/chart.dart';
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
              CsvToListConverter().convert(snapshot.data);
          List<FlSpot> dataPoints = [];
          for (int i = csvTable.length - 51, j = 0;
              i < csvTable.length - 1;
              i++, j++) {
            dataPoints.add(FlSpot(j.toDouble(), double.parse(csvTable[i][4])));
            debugPrint(csvTable[i][4]);
          }

          /* Compute price difference */
          double ratio;
          try {
            ratio = (dataPoints.last.y / dataPoints.first.y) - 1;
          } on Exception catch (e) {
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
              ? Color.fromARGB(255, 255, 77, 65)
              : Color.fromARGB(255, 63, 255, 69);
          Color sellContainerColor = diff > 0
              ? Color.fromARGB(255, 255, 223, 221)
              : Color.fromARGB(255, 228, 255, 229);
          /* Range of close price */
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

/* Post object */
class Post extends StatefulWidget {
  final String avatarPath;
  final String emojiPath;
  final String author;
  final List<Widget> stocks;
  final String imagePath;
  final String title;
  final String subtitle;
  final String publishDate;
  const Post({
    Key? key,
    required this.avatarPath,
    required this.emojiPath,
    required this.author,
    required this.stocks,
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
          /* Stock cards */
          Container(
            height: widget.stocks.length * (stockItemHeight + 20),
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              border: Border.all(color: Colors.black),
            ),
            child: ListView.separated(
              itemCount: widget.stocks.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.stocks[index];
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

/* Mock posts */
List<Widget> mockPosts = [
  const Post(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_anxious-face-with-sweat.svg",
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
    ],
    imagePath: 'assets/mock/meme2.jpg',
    title: '跟破壞性科技相比，基金管理人就是遜啦',
    subtitle: '我的100行的Python腳本平均收益都比較高',
    publishDate: '12月28日',
  ),
  const Post(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_beaming-face-with-smiling-eyes.svg",
    author: '後空翻的猿人',
    stocks: [],
    imagePath: 'assets/mock/meme3.jpg',
    title: '第一次0DTE就上手',
    subtitle: '散戶們，衝啊',
    publishDate: '2月26日',
  ),
];
