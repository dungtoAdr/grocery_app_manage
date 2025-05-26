import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsChart extends StatelessWidget {
  final int totalOrders;
  final double totalRevenue;
  final int totalProductsSold;

  const StatisticsChart({
    Key? key,
    required this.totalOrders,
    required this.totalRevenue,
    required this.totalProductsSold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxY = [
      totalOrders.toDouble(),
      totalRevenue,
      totalProductsSold.toDouble(),
    ].reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: maxY + maxY * 0.2,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Tổng đơn');
                  case 1:
                    return const Text('Doanh thu');
                  case 2:
                    return const Text('Đã bán');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: totalOrders.toDouble(),
                color: Colors.blue,
                width: 20,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: totalRevenue,
                color: Colors.green,
                width: 20,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: totalProductsSold.toDouble(),
                color: Colors.orange,
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
