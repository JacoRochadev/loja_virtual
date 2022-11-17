import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  final ProductModel product;
  const ImagesForm({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return AspectRatio(
          aspectRatio: 1,
          child: CarouselSlider(
            items: state.value.map<Widget>((image) {
              return Stack(
                children: [
                  if (image is String)
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.remove),
                        color: Colors.red,
                        onPressed: () {
                          state.didChange(state.value..remove(image));
                        },
                      ))
                ],
              );
            }).toList()
              ..add(
                Center(
                  child: Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      color: Theme.of(context).primaryColor,
                      iconSize: 50,
                      onPressed: () {
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ));
                        } else {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ));
                        }
                      },
                    ),
                  ),
                ),
              ),
            options: CarouselOptions(
              height: 400,
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
    );
  }
}
