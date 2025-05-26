import 'dart:convert';

import 'package:grocery_manager_app/models/category.dart';
import 'package:grocery_manager_app/models/order.dart';
import 'package:grocery_manager_app/models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.15/grocery";
  static const String adminUrl = "http://192.168.1.15/grocery/admin";

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/get_categories.php'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => Category.fromMap(e)).toList();
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future<bool> addCategory(Category category) async {
    try {
      final response = await http.post(
        Uri.parse("$adminUrl/add_category.php"),
        body: jsonEncode(category.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> updateCategory(Category category) async {
    try {
      final response = await http.post(
        Uri.parse("$adminUrl/update_category.php"),
        body: jsonEncode(category.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> deleteCategory(int id) async {
    try {
      final response = await http.post(
        Uri.parse("$adminUrl/delete_category.php"),
        body: {'id': id.toString()},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  //products
  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/get_products.php'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => Product.fromMap(e)).toList();
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future<bool> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse("$adminUrl/add_product.php"),
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> updateProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse("$adminUrl/update_product.php"),
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> deleteProduct(int id) async {
    try {
      final response = await http.post(
        Uri.parse("$adminUrl/delete_product.php"),
        body: {'id': id.toString()},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  //order
  static Future<List<Order>> getOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/get_orders.php'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List list = jsonData['data'];
        return list.map((e) => Order.fromJson(e)).toList();
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception(response.statusCode);
    }
  }

}
