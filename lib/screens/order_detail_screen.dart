import 'package:flutter/material.dart';
import 'order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(order.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(order.icon, size: 60, color: order.isCompleted ? Colors.green : Colors.orange),
            const SizedBox(height: 16),
            Text(
              "Status: ${order.status}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text("Detail pesanan akan ditampilkan di sini."),
          ],
        ),
      ),
    );
  }
}
