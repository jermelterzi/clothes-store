import 'package:clothes_store/models/auth.dart';
import 'package:clothes_store/models/cart.dart';
import 'package:clothes_store/models/product.dart';
import 'package:clothes_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              onPressed: () {
                product.toggleFavorite(
                  auth.token ?? '',
                  auth.uid ?? '',
                );
              },
              icon: product.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              cart.addItem(product);
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Produto adicionado com sucesso!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
