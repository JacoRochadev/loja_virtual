import 'package:flutter/material.dart';
import 'package:loja_virtual/presentetion/home/components/add_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/home_manager.dart';
import '../../../models/section.dart';
import 'item_tile.dart';
import 'section_header.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;
  const SectionStaggered({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(),
            SizedBox(
                height: 150,
                child: Consumer<Section>(
                  builder: (_, section, __) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        if (index < section.items.length) {
                          return ItemTile(section.items[index]);
                        } else {
                          return const AddTileWidget();
                        }
                      },
                      separatorBuilder: (_, __) => const SizedBox(
                        width: 4,
                      ),
                      itemCount: homeManager.editing
                          ? section.items.length + 1
                          : section.items.length,
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
