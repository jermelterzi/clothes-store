import 'package:clothes_store/models/product_grid.dart';
import 'package:flutter/material.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: const ProductGrid(),
      );
  }
}
