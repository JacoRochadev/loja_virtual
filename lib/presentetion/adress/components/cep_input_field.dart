import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
  CepInputField({Key key}) : super(key: key);
  final cepController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: cepController,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '12.345-678',
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
          onPressed: () {
            if (Form.of(context).validate()) {
              context.read<CartManager>().getAdress(cepController.text);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            disabledBackgroundColor:
                Theme.of(context).primaryColor.withAlpha(200),
          ),
          child: const Text('Buscar CEP'),
        )
      ],
    );
  }
}
