import 'package:flutter/material.dart';
import 'package:loja_virtual/components/price_card.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'components/adress_card.dart';

class AdressScreen extends StatelessWidget {
  const AdressScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Endereço'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const AdressCard(),
          Consumer<CartManager>(builder: (builder, cartManager, child) {
            return PriceCard(
              buttonText: 'Continuar para o pagamento',
              onPressed: cartManager.isAdressValid
                  ? () {
                      Navigator.of(context).pushNamed('/checkout');
                    }
                  : null,
            );
          })
        ],
      ),
    );
  }
}
