class SalesModel {
  final String productName;
  final int quantity;

  SalesModel({required this.productName, required this.quantity});

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      productName: json['product_name'],
      quantity: int.tryParse(json['quantity'].toString()) ?? 0,
    );
  }

}
