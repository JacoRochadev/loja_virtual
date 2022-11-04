import 'package:flutter/material.dart';
import 'package:loja_virtual/components/drawer_custom/drawer_custom_component.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/presentetion/home/components/Section_list.dart';
import 'package:provider/provider.dart';

import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustomComponent(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 211, 118, 130),
                  Color.fromARGB(255, 253, 181, 168),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Restaurante da Ponte'),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              ),
              Consumer<HomeManager>(builder: (_, homeManager, __) {
                final List<Widget> children =
                    homeManager.sections.map<Widget>((section) {
                  switch (section.type) {
                    case 'List':
                      return SectionList(section: section);
                    case 'Staggered':
                      return SectionStaggered(section: section);
                    default:
                      return Container();
                  }
                }).toList();
                return SliverList(
                  delegate: SliverChildListDelegate(children),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
