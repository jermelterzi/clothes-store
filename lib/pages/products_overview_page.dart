import 'package:clothes_store/data/dummy_data.dart';
import 'package:clothes_store/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductOverviewPage extends StatelessWidget {
  ProductOverviewPage({Key? key}) : super(key: key);

  List loadedProducts = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (ctx, index) => ProductItem(product: dummyProducts[index]),
        itemCount: dummyProducts.length,
      ),
    );
  }
}
