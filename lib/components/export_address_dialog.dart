import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../models/adress.dart';

class ExportAddressDialog extends StatelessWidget {
  final Adress address;
  final ScreenshotController screenshotController = ScreenshotController();
  ExportAddressDialog({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exportar Endereços'),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Text(
            '${address.street}, ${address.number}, ${address.complement}\n'
            '${address.district}\n'
            '${address.city}/${address.state}\n'
            '${address.zip}',
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: [
        TextButton(
          onPressed: () async {
            // screenshotController.capture().then((file) async {
            //   await GallerySaver.saveImage(file.path);
            // });
          },
          child: const Text('Exportar'),
        ),
      ],
    );
  }
}
