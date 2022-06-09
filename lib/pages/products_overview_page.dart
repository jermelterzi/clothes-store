import 'package:clothes_store/data/dummy_data.dart';
import 'package:clothes_store/models/product.dart';
import 'package:clothes_store/models/product_list.dart';
import 'package:clothes_store/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline6,
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
        itemCount: loadedProducts.length,
      ),
    );
  }
}
