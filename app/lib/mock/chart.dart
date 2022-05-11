import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:flutter/material.dart';

// Generate some dummy data for the cahrt
// This will be used to draw the red line
final List<FlSpot> dummyData1 = List.generate(8, (index) {
  return FlSpot(index.toDouble(), index * Random().nextDouble());
});

// This will be used to draw the orange line
final List<FlSpot> dummyData2 = List.generate(8, (index) {
  return FlSpot(index.toDouble(), index * Random().nextDouble());
});

// This will be used to draw the blue line
final List<FlSpot> dummyData3 = List.generate(8, (index) {
  return FlSpot(index.toDouble(), index * Random().nextDouble());
});

LineChart mockChart = LineChart(
  LineChartData(
    borderData: FlBorderData(show: false),
    lineBarsData: [
      // The red line
      LineChartBarData(
        spots: dummyData1,
        isCurved: true,
        barWidth: 3,
        color: Colors.red,
      ),
    ],
  ),
);
