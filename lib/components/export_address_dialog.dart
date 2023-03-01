import 'package:flutter/material.dart';
import '../models/adress.dart';

class ExportAddressDialog extends StatelessWidget {
  final Adress address;
  const ExportAddressDialog({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exportar Endereços'),
      content: Text(
        '${address.street}, ${address.number}, ${address.complement}\n'
        '${address.district}\n'
        '${address.city}/${address.state}\n'
        '${address.zip}',
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Exportar'),
        ),
      ],
    );
  }
}
