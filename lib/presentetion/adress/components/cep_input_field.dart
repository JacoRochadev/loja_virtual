import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

import '../../../models/adress.dart';

class CepInputField extends StatelessWidget {
  final Adress adress;

  CepInputField({Key key, this.adress}) : super(key: key);
  final cepController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    if (adress.zip == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !cartManager.loading,
            controller: cepController,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'CEP',
              hintText: '46.490-000',
            ),
            keyboardType: TextInputType.number,
            validator: (cep) {
              if (cep.isEmpty) {
                return 'Campo obrigatório';
              } else if (cep.length != 8) {
                return 'CEP inválido';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: !cartManager.loading
                ? () async {
                    if (Form.of(context).validate()) {
                      await context
                          .read<CartManager>()
                          .getadress(cepController.text);
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              disabledBackgroundColor:
                  Theme.of(context).primaryColor.withAlpha(200),
            ),
            child: cartManager.loading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : const Text('Buscar CEP'),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Text(
              'CEP: ${adress.zip}',
              style: Theme.of(context).textTheme.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<CartManager>().removeAdress();
            },
            iconSize: 20,
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.edit),
          )
        ],
      );
    }
  }
}
