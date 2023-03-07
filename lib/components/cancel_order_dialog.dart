import 'package:flutter/material.dart';
import 'package:loja_virtual/models/order.dart';

class CancelOrderDialog extends StatefulWidget {
  final Order order;
  const CancelOrderDialog({Key key, this.order}) : super(key: key);

  @override
  State<CancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text('Cancelar ${widget.order.formattedId}?'),
        content: const Text('Esta ação não poderá ser desfeita!'),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await widget.order.cancel();

                Navigator.of(context).pop();
              } on Exception catch (e) {
                // TODO
              }
            },
            child: const Text(
              'Cancelar Pedido',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}
