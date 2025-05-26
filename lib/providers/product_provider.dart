import 'package:flutter/material.dart';
import 'package:grocery_manager_app/models/product.dart';
import 'package:grocery_manager_app/services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> getProducts() async {
    _products = await ApiService.getProducts();
    notifyListeners();
  }

  Future<bool> addProduct(Product product) async {
    final success = await ApiService.addProduct(product);
    if (success) {
      await getProducts();
    }
    return success;
  }

  Future<bool> updateProduct(Product product) async {
    final success = await ApiService.updateProduct(product);
    if (success) {
      await getProducts();
    }
    return success;
  }

  Future<bool> deleteProduct(int id) async {
    final success = await ApiService.deleteProduct(id);
    if (success) {
      await getProducts();
    }
    return success;
  }
}
