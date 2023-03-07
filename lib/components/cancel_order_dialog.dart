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
  String error;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text('Cancelar ${widget.order.formattedId}?'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              loading ? 'Cancelando...' : 'Esta ação não poderá ser defeita!',
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
        actions: [
          TextButton(
            onPressed: !loading
                ? () {
                    Navigator.of(context).pop();
                  }
                : null,
            child: const Text('Voltar'),
          ),
          TextButton(
            onPressed: !loading
                ? () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      await widget.order.cancel();
                      Navigator.of(context).pop();
                    } on Exception catch (e) {
                      // TODO
                    }
                  }
                : null,
            child: const Text(
              'Cancelar Pedido',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
