import 'package:clothes_store/widgets/app_drawer.dart';
import 'package:clothes_store/models/order_list.dart';
import 'package:clothes_store/widgets/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders().then((_) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pedidos'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshOrders(context),
              child: ListView.builder(
                itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
                itemCount: orders.itemsCount,
              ),
            ),
      drawer: const AppDrawer(),
    );
  }
}
