import 'package:clothes_store/data/dummy_data.dart';
import 'package:clothes_store/models/product.dart';
import 'package:flutter/material.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}