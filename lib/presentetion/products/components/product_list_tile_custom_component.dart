import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';

class ProductListTileCustomComponent extends StatelessWidget {
  final ProductModel product;
  const ProductListTileCustomComponent({Key key, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/product', arguments: product);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images.first),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                      style: Theme.of(context).textTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'A partir de',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      'R\$ ${product.basePrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
