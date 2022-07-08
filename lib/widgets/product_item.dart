import 'package:clothes_store/exception/http_exception.dart';
import 'package:clothes_store/models/product.dart';
import 'package:clothes_store/models/product_list.dart';
import 'package:clothes_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.product, {Key? key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(
        product.name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCTS_FORM,
                  arguments: product,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Produto?'),
                    content: const Text('Tem certeza?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                ).then(
                  (value) {
                    if (value ?? false) {
                      try {
                        Provider.of<ProductList>(
                          context,
                          listen: false,
                        ).removeProduct(product);
                      } on HttpException catch (error) {
                        msg.showSnackBar(
                            SnackBar(content: Text(error.toString())));
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
