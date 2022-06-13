import 'dart:math';

import 'package:clothes_store/models/cart.dart';
import 'package:clothes_store/models/order.dart';
import 'package:flutter/material.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
        0,
        Order(
          id: Random().nextDouble().toString(),
          date: DateTime.now(),
          products: cart.items.values.toList(),
          total: cart.totalAmount,
        ));
  }

  @override
  notifyListeners();
}
