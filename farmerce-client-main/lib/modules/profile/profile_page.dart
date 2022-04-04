import 'package:farmerce_client/core/auth_service.dart';
import 'package:farmerce_client/ext/user_ext.dart';
import 'package:farmerce_client/l10n/l10n.dart';
import 'package:farmerce_client/widgets/server_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../locator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(getIt<AuthService>().gUserData.value.name);
        }),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: Column(
        children: [
          Center(child: Text("Profile")),
          TextButton(
              onPressed: () {
                getIt<AuthService>().logout();
              },
              child: Text("logout")),
        ],
      ),
      bottomNavigationBar: const ServerSwitcher(),
    );
  }
}
