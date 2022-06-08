import 'package:clothes_store/pages/product_detail_page.dart';
import 'package:clothes_store/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'pages/products_overview_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductOverviewPage(),
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
        AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage()
      },
    );
  }
}
