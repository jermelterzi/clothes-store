import 'package:clothes_store/widgets/app_drawer.dart';
import 'package:clothes_store/models/order_list.dart';
import 'package:clothes_store/widgets/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pedidos'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) =>
            OrderWidget(order: orders.items[i]),
        itemCount: orders.itemsCount,
      ),
      drawer: const AppDrawer(),
    );
  }
}
