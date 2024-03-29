import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../models/product_manager.dart';
import '../../../models/section.dart';
import '../../../models/section_item.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item, {Key key}) : super(key: key);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().findProductById(item.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      onLongPress: homeManager.editing
          ? () {
              showDialog(
                  context: context,
                  builder: (_) {
                    final product = context
                        .read<ProductManager>()
                        .findProductById(item.product);
                    return AlertDialog(
                      title: const Text('Editar item'),
                      content: product != null
                          ? ListTile(
                              title: Text(product.name),
                              subtitle: Text(
                                  'R\$ ${product.basePrice.toStringAsFixed(2)}'),
                              contentPadding: EdgeInsets.zero,
                              leading: Image.network(product.images.first),
                            )
                          : const Text('Vincular um produto'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.read<Section>().removeItem(item);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Excluir',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              if (product != null) {
                                item.product = null;
                              } else {
                                final ProductModel product =
                                    await Navigator.of(context)
                                            .pushNamed('/select_product')
                                        as ProductModel;
                                item.product = product?.id;
                              }
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              product != null ? 'Desvincular' : 'Vincular',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            )),
                      ],
                    );
                  });
            }
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item.image as String,
                fit: BoxFit.cover,
              )
            : Image.file(
                item.image as File,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
