import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: ((_) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Câmera',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Galeria',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
              ],
            )),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text(
              'Câmera',
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text(
              'Galeria',
            ),
          ),
        ],
      );
    }
  }
}
