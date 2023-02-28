import 'package:flutter/material.dart';
import 'package:loja_virtual/components/custom_icon_button.dart';
import 'package:loja_virtual/models/admin_orders_manager.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../components/drawer_custom/drawer_custom_component.dart';
import '../../components/empty_card.dart';
import '../../components/order_tile.dart';

class AdminOrdersScreen extends StatelessWidget {
  final PanelController _pc = PanelController();
  AdminOrdersScreen({Key key}) : super(key: key);

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

          return SlidingUpPanel(
            controller: _pc,
            body: Column(
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
                  ),
                const SizedBox(height: 100)
              ],
            ),
            minHeight: 50,
            maxHeight: 250,
            panel: GestureDetector(
              onTap: () {
                if (!_pc.isPanelOpen) {
                  _pc.open();
                } else {
                  _pc.close();
                }
              },
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Filtros',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                          children: Status.values.map((s) {
                    return CheckboxListTile(
                      selectedTileColor: Theme.of(context).primaryColor,
                      dense: true,
                      title: Text(
                        Order.getStatusText(s),
                        style: TextStyle(
                          color:
                              s != Status.canceled ? Colors.black : Colors.red,
                        ),
                      ),
                      value: ordersManager.statusFilter.contains(s),
                      onChanged: (v) {
                        ordersManager.setStatusFilter(
                          status: s,
                          enabled: v,
                        );
                      },
                      activeColor: Theme.of(context).primaryColor,
                    );
                  }).toList()))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
