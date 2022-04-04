import 'package:farmerce_client/core/auth_service.dart';
import 'package:farmerce_client/l10n/l10n.dart';
import 'package:farmerce_client/modules/auth/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:farmerce_client/ext/user_ext.dart';

import '../../locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Text(
                lo(context).hi(getIt<AuthService>().gUserData.value.name));
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                onTap: () => Get.toNamed('/profile'),
                child: CircleAvatar(
                  child: Text("A"),
                ),
              ),
            ),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Get.toNamed('/create_nursery_page'),
                child: Text("CreateNursery")),
            ElevatedButton(
                onPressed: () => Get.toNamed('/shop_list_page'),
                child: Text("Show My Nursery")),
          ],
        )),
      ),
    );
  }
}
