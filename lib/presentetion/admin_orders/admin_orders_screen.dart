import 'package:flutter/material.dart';
import 'package:loja_virtual/models/admin_orders_manager.dart';
import 'package:provider/provider.dart';

import '../../components/drawer_custom/drawer_custom_component.dart';
import '../../components/empty_card.dart';
import '../../components/order_tile.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustomComponent(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.orders.isEmpty) {
            return const EmptyCard(
              title: 'Nenhuma venda realizada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, index) {
              return OrderTile(
                order: ordersManager.orders.reversed.toList()[index],
              );
            },
          );
        },
      ),
    );
  }
}
