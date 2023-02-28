import 'package:flutter/material.dart';
import 'package:loja_virtual/components/custom_icon_button.dart';
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
        title: const Text('Todos os Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, ordersManager, __) {
          final filteredOrders = ordersManager.filteredOrders;
          return Column(
            children: <Widget>[
              if (ordersManager.userFilter != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Pedidos de ${ordersManager.userFilter.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      CustomIconButton(
                        iconData: Icons.close,
                        color: Colors.white,
                        onTap: () {
                          ordersManager.setUserFilter(null);
                        },
                      )
                    ],
                  ),
                ),
              if (filteredOrders.isEmpty)
                const Expanded(
                  child: EmptyCard(
                    title: 'Nenhuma venda realizada!',
                    iconData: Icons.border_clear,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (_, index) {
                        return OrderTile(
                          order: filteredOrders[index],
                          showControls: true,
                        );
                      }),
                )
            ],
          );
        },
      ),
    );
  }
}
