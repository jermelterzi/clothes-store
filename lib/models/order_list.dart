import 'dart:convert';

import 'package:clothes_store/models/cart.dart';
import 'package:clothes_store/models/cart_item.dart';
import 'package:clothes_store/models/order.dart';
import 'package:clothes_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Order> _items;

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  OrderList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  Future<void> loadOrders() async {
    List<Order> items = [];

    final result = await http.get(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
    );

    if (result.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(result.body);
    data.forEach(
      (orderId, orderData) {
        items.add(
          Order(
            id: orderId,
            date: DateTime.parse(orderData['date']),
            total: orderData['total'],
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                id: item['id'],
                productId: item['productId'],
                name: item['name'],
                price: item['price'],
                quantity: item['quantity'],
              );
            }).toList(),
          ),
        );
      },
    );
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final result = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
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
