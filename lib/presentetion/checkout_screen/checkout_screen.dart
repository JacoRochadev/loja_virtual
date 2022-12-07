import 'package:flutter/material.dart';
import 'package:loja_virtual/components/price_card.dart';
import 'package:provider/provider.dart';

import '../../models/checkout_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckoutModel(),
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
