import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final ImagePicker picker = ImagePicker();
  final Function(File) onImageSelected;
  ImageSourceSheet({Key key, this.onImageSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> editImage(String path) async {
      final CroppedFile croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Editar Imagem',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Editar Imagem',
            cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Concluir',
          )
        ],
      );
      if (croppedFile != null) {
        onImageSelected(File(croppedFile.path));
      }
    }

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
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final file =
                        await picker.pickImage(source: ImageSource.camera);
                    editImage(file.path);
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
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final file =
                        await picker.pickImage(source: ImageSource.gallery);
                    editImage(file.path);
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
            onPressed: () async {
              final file = await picker.pickImage(source: ImageSource.camera);
              editImage(file.path);
            },
            child: const Text(
              'Câmera',
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final file = await picker.pickImage(source: ImageSource.gallery);
              editImage(file.path);
            },
            child: const Text(
              'Galeria',
            ),
          ),
        ],
      );
    }
  }
}
