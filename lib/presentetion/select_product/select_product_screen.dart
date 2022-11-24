import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_manager.dart';

class SelectProductScreen extends StatelessWidget {
  const SelectProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProductManager>(builder: (_, prodductManager, __) {
        return ListView.builder(
          itemCount: prodductManager.allProducts.length,
          itemBuilder: (_, index) {
            final product = prodductManager.allProducts[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('R\$ ${product.basePrice.toStringAsFixed(2)}'),
              leading: Image.network(product.images.first),
              onTap: () {
                Navigator.of(context).pop(product);
              },
            );
          },
        );
      }),
    );
  }
}
