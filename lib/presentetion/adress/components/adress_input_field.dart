import 'package:flutter/material.dart';

import '../../../models/adress.dart';

class AdressInputField extends StatelessWidget {
  final Adress adress;
  const AdressInputField({Key key, this.adress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String emptyValidator(String text) {
      if (text.isEmpty) {
        return 'Campo obrigatório';
      }
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: adress.street,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida',
            hintText: 'Av. Brasil',
          ),
          validator: emptyValidator,
          onSaved: (t) => adress.street = t,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                initialValue: adress.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Número',
                  hintText: '123',
                ),
                keyboardType: TextInputType.number,
                validator: emptyValidator,
                onSaved: (t) => adress.number = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                initialValue: adress.complement,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Complemento',
                  hintText: 'Opcional',
                ),
                onSaved: (t) => adress.complement = t,
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: adress.district,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Bairro',
            hintText: 'Guanabara',
          ),
          validator: emptyValidator,
          onSaved: (t) => adress.district = t,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextFormField(
                enabled: false,
                initialValue: adress.city,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Cidade',
                  hintText: 'Campinas',
                ),
                validator: emptyValidator,
                onSaved: (t) => adress.city = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                initialValue: adress.state,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'UF',
                  hintText: 'SP',
                  counterText: '',
                ),
                maxLength: 2,
                validator: (e) {
                  if (e.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (e.length != 2) {
                    return 'Inválido';
                  }
                  return null;
                },
                onSaved: (t) => adress.state = t,
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
          onPressed: () {},
          child: const Text('Calcular Frete'),
        ),
      ],
    );
  }
}
