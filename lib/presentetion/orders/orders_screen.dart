import 'package:flutter/material.dart';
import 'package:loja_virtual/components/drawer_custom/drawer_custom_component.dart';
import 'package:loja_virtual/components/empty_card.dart';
import 'package:loja_virtual/components/login_card.dart';
import 'package:loja_virtual/models/orders_manager.dart';
import 'package:provider/provider.dart';

import '../../components/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustomComponent(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.user == null) {
            return const LoginCard();
          }
          if (ordersManager.orders.isEmpty) {
            return const EmptyCard(
              title: 'Nenhuma compra encontrada!',
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
