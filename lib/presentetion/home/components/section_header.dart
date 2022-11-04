import 'package:flutter/material.dart';

import '../../../models/section.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.section, {Key key}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
      ),
    );
  }
}
