import 'package:flutter/material.dart';
import 'package:loja_virtual/components/price_card.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

import '../../models/checkout_manager.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: ListView(children: [
          PriceCard(
            buttonText: 'Finalizar Pedido',
            onPressed: () {},
          )
        ]),
      ),
    );
  }
}
