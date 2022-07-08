import 'dart:convert';

import 'package:clothes_store/models/cart.dart';
import 'package:clothes_store/models/order.dart';
import 'package:clothes_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final result = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'name': cartItem.name,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  })
              .toList(),
        },
      ),
    );

    final id = jsonDecode(result.body)['name'];
    _items.insert(
        0,
        Order(
          id: id,
          date: DateTime.now(),
          products: cart.items.values.toList(),
          total: cart.totalAmount,
        ));
  }

  @override
  notifyListeners();
}
