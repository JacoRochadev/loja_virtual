import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_product.dart';

class OrderProductTile extends StatelessWidget {
  final CartProduct cartProduct;
  const OrderProductTile({Key key, this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [],
      ),
    );
  }
}
