import 'package:clothes_store/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'R\$ ${order.total.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yy hh:mm').format(order.date),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.expand_more),
        ),
      ),
    );
  }
}
