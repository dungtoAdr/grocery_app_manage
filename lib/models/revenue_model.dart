class RevenueModel {
  final String date;
  final double total;

  RevenueModel({required this.date, required this.total});

  factory RevenueModel.fromJson(Map<String, dynamic> json) {
    return RevenueModel(
      date: json['date'],
      total: double.tryParse(json['total'].toString()) ?? 0.0,
    );
  }

}
