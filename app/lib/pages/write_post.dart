import 'dart:convert';

import 'package:app/components/data_abstraction.dart';
import 'package:app/components/emoji_button.dart';
import 'package:app/components/stock_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:app/global_variables.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WritePostPage extends StatefulWidget {
  const WritePostPage({Key? key}) : super(key: key);
  @override
  _WritePostPageState createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  int _moodIndex = -1;
  String _moodStr = "";
  final _numController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _holdingController = TextEditingController();
  List<StockData> _stockDataList = [];

  Widget stockLineChartChild() {
    return ListView(children: [
      for (var i = 0; i < _stockDataList.length; i++)
        ListTile(
          title: StockLineChart(stockData: _stockDataList[i]),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => setState(() {}),
          ),
        ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: navbarColor,
        title: const Text("發表貼文"),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: postLRMargin,
          right: postLRMargin,
          top: 3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add emoji
            RichText(
              text: TextSpan(
                text: "您的心情: ",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                children: [
                  if (_moodIndex != -1)
                    WidgetSpan(
                      child: SvgPicture.asset(
                        "assets/icon/${emoji[_moodIndex]}.svg",
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                  if (_moodIndex != -1)
                    TextSpan(
                      text: " $_moodStr",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (int i = 0; i < emoji.length; i++)
                  EmojiButton(
                    emojiIndex: i,
                    onPressed: () => setState(() {
                      _moodIndex = i;
                      _moodStr = emojiStr[i];
                    }),
                  )
              ],
            ),
            const Divider(
              height: 1,
            ),

            // Write message
            const TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 4,
              decoration: InputDecoration(
                hintText: "想說的話",
                border: InputBorder.none,
              ),
            ),
            const Divider(
              height: 1,
            ),

            // Add stock cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: TextField(
                      controller: _numController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "股票編號",
                        isDense: true,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: TextField(
                      controller: _startDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        hintText: "買進日期",
                        isDense: true,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: TextField(
                      controller: _endDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        hintText: "賣出日期",
                        isDense: true,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: TextField(
                      controller: _holdingController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        hintText: "股數",
                        isDense: true,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                  ),
                  child: const Text(
                    "新增交易資訊",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => setState(() {
                    int num = int.parse(_numController.text);
                    String startDate = _startDateController.text;
                    String endDate = _endDateController.text;
                    int holding = int.parse(_holdingController.text);

                    StockData newData = StockData(
                      num: num,
                      startDate: startDate,
                      endDate: endDate,
                      holding: holding,
                    );

                    _stockDataList.add(newData);
                  }),
                ),
              ],
            ),

            // Stock Cards
            Expanded(
              child: stockLineChartChild(),
            )
          ],
        ),
      ),
    );
  }
}
