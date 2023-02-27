import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/page_manager.dart';

class DrawerTileCustomComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final int page;

  const DrawerTileCustomComponent({Key key, this.icon, this.title, this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Icon(
                icon,
                size: 32,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    color: curPage == page ? primaryColor : Colors.grey[700],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
