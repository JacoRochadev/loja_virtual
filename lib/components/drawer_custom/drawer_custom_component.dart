import 'package:flutter/material.dart';
import 'package:loja_virtual/components/drawer_custom/drawer_header_custom_component.dart';

import 'package:loja_virtual/components/drawer_custom/drawer_tile_custom_component.dart';
import 'package:provider/provider.dart';

import '../../models/user_manager.dart';

class DrawerCustomComponent extends StatelessWidget {
  const DrawerCustomComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 203, 236, 241),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              const DrawerHeaderCustomComponent(),
              const Divider(),
              const DrawerTileCustomComponent(
                  icon: Icons.home, title: 'Início', page: 0),
              const DrawerTileCustomComponent(
                  icon: Icons.list, title: 'Produtos', page: 1),
              const DrawerTileCustomComponent(
                  icon: Icons.playlist_add_check,
                  title: 'Meus Pedidos',
                  page: 2),
              const DrawerTileCustomComponent(
                icon: Icons.location_on,
                title: 'Lojas',
                page: 3,
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnabled) {
                    return Column(
                      children: const [
                        Divider(),
                        DrawerTileCustomComponent(
                          icon: Icons.settings,
                          title: 'Usuários',
                          page: 4,
                        ),
                        DrawerTileCustomComponent(
                          icon: Icons.settings,
                          title: 'Pedidos',
                          page: 5,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
