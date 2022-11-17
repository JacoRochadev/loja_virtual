import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/presentetion/products/components/product_list_tile_custom_component.dart';
import 'package:provider/provider.dart';
import '../../components/drawer_custom/drawer_custom_component.dart';
import '../../models/user_manager.dart';
import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustomComponent(),
      appBar: AppBar(
        title: Consumer<ProductManager>(builder: (_, productManager, __) {
          if (productManager.search.isEmpty) {
            return const Text('Produtos');
          } else {
            return LayoutBuilder(
              builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(
                        initialText: productManager.search,
                      ),
                    );
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  child: SizedBox(
                    width: constraints.biggest.width,
                    child: Text(
                      productManager.search,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          }
        }),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  final search = await showDialog<String>(
                    context: context,
                    builder: (_) => SearchDialog(
                      initialText: productManager.search,
                    ),
                  );
                  if (search != null) {
                    productManager.search = search;
                  }
                },
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.close),
                onPressed: () async {
                  productManager.search = '';
                },
              );
            }
          }),
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (userManager.adminEnabled) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/edit_product',
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTileCustomComponent(
                  product: filteredProducts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
