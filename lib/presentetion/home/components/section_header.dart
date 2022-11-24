import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/home_manager.dart';
import '../../../models/section.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();
    final homeManager = context.watch<HomeManager>();
    if (homeManager.editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: const InputDecoration(
                    hintText: 'Título',
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                  onChanged: (text) => section.name = text,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                color: Colors.white,
                onPressed: () {
                  homeManager.removeSection(section);
                },
              ),
            ],
          ),
          if (section.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                section.error,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? 'Sem nome',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
        ),
      );
    }
  }
}
