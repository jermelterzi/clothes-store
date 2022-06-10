import 'dart:math';

import 'package:clothes_store/models/cart_item.dart';
import 'package:clothes_store/models/product.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item => {..._items};

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          price: existingItem.price,
          productId: existingItem.productId,
          quantity: existingItem.quantity + 1,
          name: existingItem.name,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
            id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.name,
            price: product.price,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
