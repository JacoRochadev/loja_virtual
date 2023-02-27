import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  final ItemSize size;
  const SizeWidget({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductModel>();
    final selected = size == product.selectedSize;

    Color colores;
    if (!size.hasStock) {
      colores = Colors.red.withAlpha(50);
    } else if (selected) {
      colores = Theme.of(context).primaryColor;
    } else {
      colores = Colors.grey;
    }
    return GestureDetector(
      onTap: () {
        if (size.hasStock) {
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: colores,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: colores,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name ?? '',
                style: Theme.of(context).textTheme.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${size.price?.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium.copyWith(
                      color: colores,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
