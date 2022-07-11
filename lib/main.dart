import 'package:clothes_store/models/auth.dart';
import 'package:clothes_store/models/cart.dart';
import 'package:clothes_store/models/order.dart';
import 'package:clothes_store/models/order_list.dart';
import 'package:clothes_store/models/product_list.dart';
import 'package:clothes_store/pages/auth_page.dart';
import 'package:clothes_store/pages/cart_page.dart';
import 'package:clothes_store/pages/orders_page.dart';
import 'package:clothes_store/pages/product_detail_page.dart';
import 'package:clothes_store/pages/product_form_page.dart';
import 'package:clothes_store/pages/products_page.dart';
import 'package:clothes_store/pages/splash_page.dart';
import 'package:clothes_store/utils/app_routes.dart';
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
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.uid ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
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
            headline5: const TextStyle(fontFamily: 'Lato'),
            headline6: const TextStyle(fontFamily: 'Lato', color: Colors.black),
            subtitle1: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 10,
              color: Colors.black,
            ),
            subtitle2: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const SplashPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCTS_FORM: (ctx) => const ProductFormPage(),
        },
      ),
    );
  }
}
