import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final ImagePicker picker = ImagePicker();
  final Function(File) onImageSelected;
  ImageSourceSheet({Key key, this.onImageSelected}) : super(key: key);

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
                  onPressed: () async {
                    final file =
                        await picker.pickImage(source: ImageSource.camera);
                    onImageSelected(File(file.path));
                  },
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
                  onPressed: () async {
                    final file =
                        await picker.pickImage(source: ImageSource.gallery);
                    onImageSelected(File(file.path));

                    //final file = XFile(picker.pickImage(source: ImageSource.gallery));
                  },
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
