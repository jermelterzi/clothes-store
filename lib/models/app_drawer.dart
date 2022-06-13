import 'package:clothes_store/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(

            title: const Text('Bem vindo Usuário!'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text(
              'Loja',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () => Navigator.of(context).pushNamed(
              AppRoutes.HOME,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text(
              'Pedidos',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () => Navigator.of(context).pushNamed(
              AppRoutes.ORDERS,
            ),
          ),
        ],
      ),
    );
  }
}
