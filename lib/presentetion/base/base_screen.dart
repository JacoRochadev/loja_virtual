import 'package:flutter/material.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/presentetion/products/products_screen.dart';
import 'package:provider/provider.dart';
import '../../components/drawer_custom/drawer_custom_component.dart';

class BaseScreen extends StatelessWidget {
  final pageController = PageController();
  BaseScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //LoginScreen(),

          Scaffold(
            drawer: const DrawerCustomComponent(),
            appBar: AppBar(
              title: const Text('Home1'),
            ),
          ),
          const ProductsScreen(),

          Scaffold(
            drawer: const DrawerCustomComponent(),
            appBar: AppBar(
              title: const Text('Home3'),
            ),
          ),
        ],
      ),
    );
  }
}
