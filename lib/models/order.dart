import 'package:grocery_manager_app/models/order_detail.dart';

class Order {
  final int? id;
  final String uid;
  final int address_id;
  final int status;
  final double total;
  final List<OrderDetail> details;

  Order({
    this.id,
    required this.uid,
    required this.address_id,
    required this.status,
    required this.total,
    required this.details,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: int.tryParse(json['id'].toString()),
      uid: json['user_uid'],
      address_id: int.tryParse(json['address_id'].toString()) ?? 0,
      status: int.tryParse(json['status'].toString()) ?? 0,
      total: double.tryParse(json['total'].toString()) ?? 0.0,
      details: (json['details'] as List)
          .map((item) => OrderDetail.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_uid': uid,
      'address_id': address_id,
      'status': status,
      'total': total,
      'details': details.map((d) => d.toJson()).toList(),
    };
  }
}
