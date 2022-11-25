import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_manager.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key key,
    this.buttonText,
    this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Resumo do Pedido',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Subtotal'),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}')
              ],
            ),
            const Divider(),
            if (deliveryPrice != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Entrega'),
                  Text('R\$ ${deliveryPrice.toStringAsFixed(2)}')
                ],
              ),
              const Divider(),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  'R\$ ${totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                disabledBackgroundColor:
                    Theme.of(context).primaryColor.withAlpha(200),
              ),
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
