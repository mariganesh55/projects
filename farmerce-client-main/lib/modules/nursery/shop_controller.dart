import 'package:farmerce_client/graphql/farmerce.schema.schema.gql.dart';
import 'package:farmerce_client/graphql/nursery.data.gql.dart';
import 'package:farmerce_client/graphql/nursery.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:get/get.dart';

import '../../locator.dart';

class ShopListController extends GetxController with StateMixin<GShopListData> {
  // var shopList = GShopListData().obs;
  final query =
      GShopListReq((b) => b..fetchPolicy = FetchPolicy.CacheAndNetwork);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getShopList();
  }

  Future<void> userRefresh() async {
    getIt<Client>().requestController.add(query);
    await Future.delayed(Duration(milliseconds: 800));
  }

  void getShopList() {
    change(null, status: RxStatus.loading());
    final response = getIt<Client>().request(query);
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
      GShopListData? gShopListData = or.data;
      if (gShopListData == null) return;
      change(gShopListData, status: RxStatus.success());
    });
  }

}
