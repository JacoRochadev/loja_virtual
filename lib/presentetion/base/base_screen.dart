import 'package:flutter/material.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/presentetion/home/home_screen.dart';
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
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const HomeScreen(),
              const ProductsScreen(),
              Scaffold(
                drawer: const DrawerCustomComponent(),
                appBar: AppBar(
                  title: const Text('Home3'),
                ),
              ),
              Scaffold(
                drawer: const DrawerCustomComponent(),
                appBar: AppBar(
                  title: const Text('Home4'),
                ),
              ),
              if (userManager.adminEnabled) ...[
                Scaffold(
                  drawer: const DrawerCustomComponent(),
                  appBar: AppBar(
                    title: const Text('Usuários'),
                  ),
                ),
                Scaffold(
                  drawer: const DrawerCustomComponent(),
                  appBar: AppBar(
                    title: const Text('Pedidos'),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
