import 'dart:convert';

import 'package:clothes_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();

    final result = await http.patch(
      Uri.parse('${Constants.PRODUCT_BASE_URL}/$id.json'),
      body: jsonEncode(
        {
          'isFavorite': isFavorite,
        },
      ),
    );

    if (result.statusCode >= 400) {}
  }
}
