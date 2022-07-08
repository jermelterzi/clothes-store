import 'dart:convert';
import 'dart:math';

import 'package:clothes_store/data/dummy_data.dart';
import 'package:clothes_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  final _baseURL = 'https://clothes-store-bd94f-default-rtdb.firebaseio.com/';

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    http.post(
      Uri.parse('$_baseURL/products.json'),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageURL': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );

    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  // 1º Version
  // bool _showFavoriteOnly = false;
  //
  // List<Product> get items {
  //   if (_showFavoriteOnly) {
  //     return _items.where((prod) => prod.isFavorite).toList();
  //   }
  //   return [..._items];
  // }
  //
  // void showFavorites() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }
  //
  // void addProduct(Product product) {
  //   _items.add(product);
  //   notifyListeners();
  // }
}
