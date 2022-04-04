import 'package:farmerce_client/graphql/farmerce.schema.schema.gql.dart';
import 'package:farmerce_client/graphql/nursery.data.gql.dart';
import 'package:farmerce_client/graphql/nursery.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../locator.dart';

class CreateNurseryController extends GetxController
    with StateMixin<GCreateShopData> {
  TextEditingController nurseryNameController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change(null, status: RxStatus.empty());
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nurseryNameController.dispose();
  }

  void nurseryCreate(GInfrastructureEnum infrastructureEnum) {
    change(null, status: RxStatus.loading());
    final mutation = GCreateShopReq((b) => b
      ..vars.name = nurseryNameController.text
      ..vars.infrastructure = infrastructureEnum);
    final response = getIt<Client>().request(mutation);
    response.listen((or) {
      if (or.hasErrors) {
        if (or.linkException != null) {
          change(null,
              status: RxStatus.error(
                or.linkException.toString(),
              ));
        } else {
          change(
            null,
            status: RxStatus.error(or.graphqlErrors?.first.toString()),
          );
        }
        return;
      }
      GCreateShopData? gCreateShopData = or.data;
      if (gCreateShopData == null) return;
      change(gCreateShopData, status: RxStatus.success());
      Get.toNamed('/home');
    });
  }
}
