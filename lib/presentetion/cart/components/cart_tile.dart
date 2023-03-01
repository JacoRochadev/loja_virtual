import 'package:flutter/material.dart';
import 'package:loja_virtual/components/custom_icon_button.dart';
import 'package:provider/provider.dart';

import '../../../models/cart_product.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  const CartTile(this.cartProduct, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed('/product', arguments: cartProduct.product),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                if (cartProduct.product.images.first != null)
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(cartProduct.product.images.first),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartProduct.product.name,
                          style:
                              Theme.of(context).textTheme.titleMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tamanho: ${cartProduct.size}',
                          style:
                              Theme.of(context).textTheme.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Consumer<CartProduct>(
                          builder: (_, cartProduct, __) {
                            if (cartProduct.hasStock) {
                              return Text(
                                'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              );
                            } else {
                              return Text(
                                'Sem estoque suficiente',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<CartProduct>(
                  builder: (_, cartProduct, __) {
                    return Column(
                      children: [
                        CustomIconButton(
                          iconData: Icons.add,
                          color: Theme.of(context).primaryColor,
                          onTap: cartProduct.increment,
                        ),
                        Text(
                          '${cartProduct.quantity}',
                          style:
                              Theme.of(context).textTheme.titleLarge.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        CustomIconButton(
                          iconData: Icons.remove,
                          color: cartProduct.quantity > 1
                              ? Theme.of(context).primaryColor
                              : Colors.red,
                          onTap: cartProduct.decrement,
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
