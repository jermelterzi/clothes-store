import 'dart:convert';
import 'dart:math';

import 'package:clothes_store/exception/http_exception.dart';
import 'package:clothes_store/models/product.dart';
import 'package:clothes_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  ProductList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  Future<void> loadProducts() async {
    _items.clear();

    final result = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
    );

    if (result.body == 'null') return;

    final favResult = await http.get(
      Uri.parse('${Constants.USER_FAVORITES_URL}/$_userId.json?auth=$_token'),
    );

    Map<String, dynamic> favData =
        favResult.body == 'null' ? {} : jsonDecode(favResult.body);

    Map<String, dynamic> data = jsonDecode(result.body);
    data.forEach(
      (productId, productData) {
        final isFavorite = favData[productId] ?? false;
        _items.add(
          Product(
            id: productId,
            name: productData['name'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: isFavorite,
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final result = await http.post(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        },
      ),
    );

    final id = jsonDecode(result.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse(
            '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
            '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'N??o foi poss??vel apagar o produto',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
