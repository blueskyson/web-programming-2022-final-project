import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app/mock/chart.dart';
import 'package:csv/csv.dart';

/* Stock object */
class StockLineChart extends StatelessWidget {
  final int num;
  final String startDate;
  final String endDate;
  const StockLineChart({
    Key? key,
    required this.num,
    required this.startDate,
    required this.endDate,
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
              dataPoints
                  .add(FlSpot(j.toDouble(), double.parse(csvTable[i][4])));
              debugPrint(csvTable[i][4]);
            }

            /* Line chart style */
            Color lineColor = dataPoints.last.y > dataPoints.first.y
                ? Colors.red
                : Colors.green;
            /* Range of close price */
            return Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.5,
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
                            colors: <Color>[
                              lineColor,
                              Colors.white
                            ], // red to yellow// repeats the gradient over the canvas
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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
          /* Stock line charts */
          SizedBox(
            height: widget.stocks.length * 120,
            child: ListView.separated(
              itemCount: widget.stocks.length,
              itemBuilder: (BuildContext context, int index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: widget.stocks[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
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
      StockLineChart(num: 2330, startDate: "2022/05/03", endDate: "2022/05/11"),
      StockLineChart(num: 2603, startDate: "2022/05/03", endDate: "2022/05/11"),
      StockLineChart(num: 2002, startDate: "2022/05/03", endDate: "2022/05/11"),
      StockLineChart(num: 2454, startDate: "2022/05/03", endDate: "2022/05/11"),
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
