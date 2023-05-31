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
            color: Colors.brown[900],
          ),
          ListView(
            children: <Widget>[
              const DrawerHeaderCustomComponent(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              const DrawerTileCustomComponent(
                icon: Icons.home,
                title: 'Início',
                page: 0,
              ),
              const DrawerTileCustomComponent(
                icon: Icons.list,
                title: 'Produtos',
                page: 1,
              ),
              const DrawerTileCustomComponent(
                icon: Icons.playlist_add_check,
                title: 'Meus Pedidos',
                page: 2,
              ),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
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
