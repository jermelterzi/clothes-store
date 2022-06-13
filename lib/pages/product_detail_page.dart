import 'package:clothes_store/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'R\$ ${product.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              width: double.infinity,
              child: Text(
                product.description,
                style: const TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
