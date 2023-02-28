import 'package:flutter/material.dart';
import 'package:loja_virtual/models/order.dart';

import 'order_product_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final bool showControls;

  const OrderTile({Key key, this.order, this.showControls = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: order.status == Status.canceled
                      ? Colors.red
                      : Theme.of(context).primaryColor,
                  fontSize: 14),
            ),
          ],
        ),
        children: [
          Column(
            children: order.items.map((e) {
              return OrderProductTile(
                cartProduct: e,
              );
            }).toList(),
          ),
          if (showControls && order.status != Status.canceled)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: order.cancel,
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: order.back,
                  child: Text('Regredir',
                      style: TextStyle(color: Colors.grey[850])),
                ),
                TextButton(
                  onPressed: order.advance,
                  child: Text('Avançar',
                      style: TextStyle(color: Colors.grey[850])),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Endereço',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
