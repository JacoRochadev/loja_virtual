import 'package:flutter/material.dart';
import 'package:loja_virtual/components/drawer_custom/drawer_header_custom_component.dart';

import 'package:loja_virtual/components/drawer_custom/drawer_tile_custom_component.dart';

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
            children: const <Widget>[
              DrawerHeaderCustomComponent(),
              Divider(),
              DrawerTileCustomComponent(
                  icon: Icons.home, title: 'Início', page: 0),
              DrawerTileCustomComponent(
                  icon: Icons.list, title: 'Produtos', page: 1),
              DrawerTileCustomComponent(
                  icon: Icons.playlist_add_check,
                  title: 'Meus Pedidos',
                  page: 2),
              DrawerTileCustomComponent(
                  icon: Icons.location_on, title: 'Lojas', page: 3),
            ],
          ),
        ],
      ),
    );
  }
}
