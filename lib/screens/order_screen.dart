import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../models/order_detail.dart';
import '../providers/order_provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Set<int> expandedOrders = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đơn hàng")),
      body: Consumer<OrderProvider>(
        builder: (context, value, child) {
          List<Order> orders = value.orders;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Order order = orders[index];
              List<OrderDetail> orderDetails = order.details;
              bool isExpanded = expandedOrders.contains(order.id);

              return Card(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.card_giftcard, color: Colors.green),
                      title: Text(
                        "Order #${order.id}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Order Total: \$${order.total.toString()}",
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isExpanded) {
                              expandedOrders.remove(order.id);
                            } else {
                              expandedOrders.add(order.id!);
                            }
                          });
                        },
                      ),
                    ),
                    if (isExpanded)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orderDetails.length,
                        itemBuilder: (context, detailIndex) {
                          final detail = orderDetails[detailIndex];
                          return ListTile(
                            leading: Image.network(
                              detail.product_image!,
                              width: 40,
                              height: 40,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    detail.product_image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            ),
                            title: Text(detail.product_name!),
                            subtitle: Text(
                              "Quantity: ${detail.quantity} | Subtotal: \$${detail.sub_total}",
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
