import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

import '../../../models/adress.dart';
import 'adress_input_field.dart';
import 'cep_input_field.dart';

class AdressCard extends StatelessWidget {
  const AdressCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Form(child: Consumer<CartManager>(
          builder: (_, cartManager, __) {
            final adress = cartManager.adress ?? Adress();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Endereço de Entrega',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                CepInputField(adress: adress),
                if (adress.zip != null && cartManager.deliveryPrice == null)
                  AdressInputField(adress: adress),
                if (adress.zip != null && cartManager.deliveryPrice != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                        '${adress.street}, ${adress.number}\n${adress.district}\n'
                        '${adress.city} - ${adress.state}'),
                  ),
              ],
            );
          },
        )),
      ),
    );
  }
}
