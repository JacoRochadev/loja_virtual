import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  final ProductModel product;
  const EditProductScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Produto'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImagesForm(
            product: product,
          ),
        ],
      ),
    );
  }
}
