import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chart_provider.dart';
import '../widgets/revenue_bar_chart.dart';
import '../widgets/sales_pie_chart.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ChartProvider>(context, listen: false);
    provider.fetchRevenueData();
    provider.fetchSalesData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Thống kê")),
        body: provider.revenues.isEmpty || provider.sales.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Doanh thu theo ngày',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: RevenueBarChart(data: provider.revenues),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Tỷ lệ bán theo sản phẩm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: SalesPieChart(data: provider.sales),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: SalesPieChart(data: provider.sales),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
