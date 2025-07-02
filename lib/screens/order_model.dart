import 'package:flutter/material.dart';

class OrderModel {
  final String title;
  final String status;
  final IconData icon;
  final bool isCompleted;

  OrderModel({
    required this.title,
    required this.status,
    required this.icon,
    required this.isCompleted,
  });
}
