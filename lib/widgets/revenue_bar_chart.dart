import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/revenue_model.dart';

class RevenueBarChart extends StatelessWidget {
  final List<RevenueModel> data;

  const RevenueBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(data.length, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(toY: data[index].total, color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(0)),width: 30),
            ],
          );
        }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index < data.length) {
                  return Text(data[index].date.substring(5));
                }
                return const Text('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
