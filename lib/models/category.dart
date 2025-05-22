import 'package:flutter/material.dart';

class Category {
  final int? id;
  final String name;
  final String image;
  final int color;

  Category({
    this.id,
    required this.name,
    required this.image,
    required this.color,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: int.parse(map['id']),
      name: map['name'],
      image: map['image'],
      color: int.parse(map['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'color': color};
  }
}
