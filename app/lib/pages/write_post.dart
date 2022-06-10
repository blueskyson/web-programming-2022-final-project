import 'dart:convert';
import 'package:app/components/data_abstraction.dart';
import 'package:app/components/emoji_button.dart';
import 'package:app/components/stock_line_chart.dart';
import 'package:app/mock/user.dart';
import 'package:flutter/material.dart';
import 'package:app/global_variables.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../utils/time.dart';

class WritePostPage extends StatefulWidget {
  const WritePostPage({Key? key}) : super(key: key);
  @override
  _WritePostPageState createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage>
    with AutomaticKeepAliveClientMixin<WritePostPage> {
  int _moodIndex = -1;
  String _moodStr = "";
  final _msgController = TextEditingController();
  final _numController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _holdingController = TextEditingController();
  final List<StockData> _stockDataList = [];

  Widget stockLineChartChild() {
    return ListView(children: [
      for (var i = 0; i < _stockDataList.length; i++)
        Row(
          children: [
            Expanded(
              flex: 9,
              child: StockLineChart(stockData: _stockDataList[i]),
            ),
            Expanded(
              flex: 1,
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  margin: const EdgeInsets.all(0),
                  child: IconButton(
                    highlightColor: const Color.fromARGB(255, 255, 153, 146),
                    color: Colors.red,
                    icon: const Icon(Icons.cancel),
                    onPressed: () => setState(() {
                      _stockDataList.removeAt(i);
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Add stock line chart button
    const double buttonThreshold = 450;

    Widget addStockButton = TextButton(
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
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,

      // Top bar
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: navbarColor,
        title: const Text("發表貼文"),
        actions: [
          Container(
            padding: const EdgeInsets.only(
              right: 10,
              top: 10,
              bottom: 10,
            ),

            /* Publish Post */
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                "發佈",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (_moodIndex == -1 || _msgController.text == "") {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        content: SizedBox(
                          width: 70,
                          height: 40,
                          child: Center(
                            child: Text("請輸入心情及想說的話"),
                          ),
                        ),
                      );
                    },
                  );
                  return;
                }

                final body = jsonEncode({
                  "username": mockUser.account,
                  "moodid": _moodIndex,
                  "author": mockUser.name,
                  "stocklist": jsonEncode(_stockDataList),
                  "emojicounts": jsonEncode(
                    EmojiCounts(counts: [0, 0, 0, 0, 0, 0, 0]),
                  ),
                  "message": _msgController.text,
                  "publishdate": getCurrentTime(),
                });

                debugPrint(body);
                try {
                  final response = await http.post(
                    Uri.http("luffy.ee.ncku.edu.tw:8647", "/post"),
                    headers: {'Content-Type': 'application/json'},
                    body: body,
                  );
                  debugPrint(response.body);

                  // Success publishing
                  if (response.statusCode == 200) {
                    Navigator.of(context).pop();
                  }

                  // Error publishing
                  else {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return const AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          content: SizedBox(
                            width: 70,
                            height: 40,
                            child: Center(
                              child: Text("發送失敗"),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        content: SizedBox(
                          width: 70,
                          height: 40,
                          child: Center(
                            child: Text("網路錯誤"),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),

      // Body
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
            TextField(
              controller: _msgController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 4,
              decoration: const InputDecoration(
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
                if (MediaQuery.of(context).size.width > buttonThreshold)
                  addStockButton,
              ],
            ),
            if (MediaQuery.of(context).size.width <= buttonThreshold)
              addStockButton,

            // Stock Cards
            Expanded(
              child: stockLineChartChild(),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
