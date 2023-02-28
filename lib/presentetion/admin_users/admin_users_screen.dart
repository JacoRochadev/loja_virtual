import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/components/drawer_custom/drawer_custom_component.dart';
import 'package:loja_virtual/models/admin_orders_manager.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:provider/provider.dart';

import '../../models/admin_users_manager.dart';

class AdminUserScreen extends StatelessWidget {
  const AdminUserScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustomComponent(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUserManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name,
                  style: Theme.of(context).textTheme.titleSmall.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                ),
                subtitle: Text(
                  adminUsersManager.users[index].email,
                  style: Theme.of(context).textTheme.titleSmall.copyWith(
                        color: Colors.white,
                      ),
                ),
                onTap: () {
                  context
                      .read<AdminOrdersManager>()
                      .setUserFilter(adminUsersManager.users[index]);

                  context.read<PageManager>().setPage(5);
                },
              );
            },
            highlightTextStyle: Theme.of(context).textTheme.titleLarge.copyWith(
                  color: Colors.white,
                ),
            indexedHeight: (index) => 80,
            strList: adminUsersManager.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}
