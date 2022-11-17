import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  final ProductModel product;

  EditProductScreen({ProductModel product, Key key})
      : editing = product != null,
        product = product != null ? product.clone() : ProductModel(),
        super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bool editing;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(product: product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                    validator: (name) {
                      if (name.length < 6) {
                        return 'Título muito curto';
                      }
                      return null;
                    },
                    onSaved: (name) => product.name = name,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ...',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.black,
                        ),
                    validator: (description) {
                      if (description.length < 4) {
                        return 'Descrição muito curta';
                      }
                      return null;
                    },
                    onSaved: (description) => product.description = description,
                  ),
                  SizesForm(product: product),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        disabledBackgroundColor:
                            Theme.of(context).primaryColor.withAlpha(200),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          product.save();
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
