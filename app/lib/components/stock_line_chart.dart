import 'package:app/components/data_abstraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:csv/csv.dart';
import 'package:app/global_variables.dart';

class StockLineChart extends StatelessWidget {
  final StockData stockData;
  const StockLineChart({
    Key? key,
    required this.stockData,
  }) : super(key: key);

  Future<String> _drawChart() async {
    return await rootBundle
        .loadString("assets/csv/${stockData.num}_history.csv");
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
          int diffAmount = (stockData.holding * diff).round().abs();
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
                      "${stockData.num}",
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
            child: Placeholder(
              fallbackHeight: stockItemHeight,
              color: Colors.transparent,
            ),
          );
        }
      },
    );
  }
}
