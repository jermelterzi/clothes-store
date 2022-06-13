import 'package:clothes_store/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  OrderWidget({Key? key, required this.order}) : super(key: key);

  final Order order;
  bool _isExpanded = false;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'R\$ ${widget.order.total.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat('dd/MM/yy hh:mm').format(widget.order.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  widget._isExpanded = !widget._isExpanded;
                });
              },
              icon: const Icon(Icons.expand_more),
            ),
          ),
          if (widget._isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: (widget.order.products.length * 24.0) + 10,
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${product.quantity}x R\$ ${product.price}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
