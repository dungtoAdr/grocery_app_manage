import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/api_service.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> getOrders() async {
    _orders = await ApiService.getOrders();
    notifyListeners();
  }

}
