import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:loja_virtual/presentetion/home/components/section_header.dart';

import 'item_tile.dart';

class SectionList extends StatelessWidget {
  final Section section;

  const SectionList({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            section,
          ),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return ItemTile(section.items[index]);
                // return AspectRatio(
                //   aspectRatio: 1,
                //   child: Image.network(
                //     section.items[index].image,
                //     fit: BoxFit.cover,
                //   ),
                // );
              },
              separatorBuilder: (_, __) => const SizedBox(
                width: 4,
              ),
              itemCount: section.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
