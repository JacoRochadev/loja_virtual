import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
