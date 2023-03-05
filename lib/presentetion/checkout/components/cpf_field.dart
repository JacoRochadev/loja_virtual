import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CpfField extends StatelessWidget {
  const CpfField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: TextFormField(
          initialValue: userManager.userModel.cpf,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'CPF',
            hintText: '000.000.000-00',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CpfInputFormatter(),
          ],
          validator: (cpf) {
            if (cpf.isEmpty) {
              return 'Campo obrigatório';
            } else if (!CPFValidator.isValid(cpf)) {
              return 'CPF inválido';
            }
            return null;
          },
          onSaved: userManager.userModel.setCpf,
        ),
      ),
    );
  }
}
