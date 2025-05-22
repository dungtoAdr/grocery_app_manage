import 'package:flutter/material.dart';
import 'package:grocery_manager_app/models/category.dart';
import 'package:grocery_manager_app/services/api_service.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> getCategories() async {
    _categories = await ApiService.getCategories();
    notifyListeners();
  }

  Future<bool> addCategory(Category category) async {
    final success = await ApiService.addCategory(category);
    if (success) {
      await getCategories();
    }
    return success;
  }

  Future<bool> updateCategory(Category category) async {
    final success = await ApiService.updateCategory(category);
    if (success) {
      await getCategories();
    }
    return success;
  }

  Future<bool> deleteCategory(int id) async {
    final success = await ApiService.deleteCategory(id);
    if (success) {
      await getCategories();
    }
    return success;
  }
}
