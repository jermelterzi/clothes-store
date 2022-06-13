import 'package:clothes_store/models/cart.dart';
import 'package:clothes_store/models/order_list.dart';
import 'package:clothes_store/models/product_list.dart';
import 'package:clothes_store/pages/cart_page.dart';
import 'package:clothes_store/pages/orders_page.dart';
import 'package:clothes_store/pages/product_detail_page.dart';
import 'package:clothes_store/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: const ProductOverviewPage(),
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.orange,
              ),
          textTheme: const TextTheme().copyWith(
            headline6: const TextStyle(fontFamily: 'Lato'),
            subtitle1: const TextStyle(fontFamily: 'Lato', fontSize: 10),
          ),
        ),
        routes: {
          AppRoutes.HOME: (ctx) => const ProductOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
        },
      ),
    );
  }
}
