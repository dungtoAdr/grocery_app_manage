import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/revenue_model.dart';
import '../models/sales_model.dart';

class ChartProvider with ChangeNotifier {
  List<RevenueModel> revenues = [];
  List<SalesModel> sales = [];

  Future<void> fetchRevenueData() async {
    final response = await http.get(Uri.parse('http://192.168.1.15/grocery/admin/api_revenue_by_date.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      revenues = List<RevenueModel>.from(jsonData['data'].map((item) => RevenueModel.fromJson(item)));
      notifyListeners();
    }
  }

  Future<void> fetchSalesData() async {
    final response = await http.get(Uri.parse('http://192.168.1.15/grocery/admin/api_sales_ratio_by_product.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      sales = List<SalesModel>.from(jsonData['data'].map((item) => SalesModel.fromJson(item)));
      notifyListeners();
    }
  }
}
