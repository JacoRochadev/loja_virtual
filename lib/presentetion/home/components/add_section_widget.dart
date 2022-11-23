import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/home_manager.dart';
import '../../../models/section.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.white.withAlpha(50),
            ),
            child: const Text('Adicionar lista'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.white.withAlpha(50),
            ),
            child: const Text('Adicionar grade'),
          ),
        ),
      ],
    );
  }
}
