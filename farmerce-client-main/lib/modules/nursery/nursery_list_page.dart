import 'package:farmerce_client/graphql/nursery.data.gql.dart';
import 'package:farmerce_client/l10n/l10n.dart';
import 'package:farmerce_client/modules/nursery/shop_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:built_collection/built_collection.dart';

class ShopListPage extends GetView<ShopListController> {
  const ShopListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ShopListController());
    return SafeArea(child: Scaffold(
      body: GetBuilder<ShopListController>(builder: (logic) {
        return RefreshIndicator(
          onRefresh: logic.userRefresh,
          child: ListView(
            children: [
              if (logic.status.isLoading)
                Center(child: CircularProgressIndicator()),
              if (logic.status.isError)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        lo(context).error,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                          logic.status.errorMessage ?? "Something went wrong"),
                    ),
                    TextButton(
                        onPressed: logic.userRefresh,
                        child: Text(lo(context).retry)),
                  ],
                ),
              if (logic.status.isSuccess) ..._buildShopList(context, logic)
            ],
          ),
        );
      }),
    ));
  }

  List<Widget> _buildShopList(BuildContext context, ShopListController logic) {
    List<Widget> shopListTiles = [];
    var shopList = logic.state?.shop;
    if (shopList == null) return shopListTiles;
    if (shopList.isEmpty) {
      return [
        Center(
            child: Text(
          "Ooops!!! You dont have any Nursery.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        )),
        TextButton(onPressed: () {}, child: Text("Add Nursery")),
      ];
    }
    for (var shop in shopList) {
      shopListTiles.add(ListTile(
        leading: const Icon(CupertinoIcons.tree),
        title: Text(shop.nursery?.name ?? ""),
        subtitle: Text(shop.nursery?.infrastructure?.name ?? ""),
        trailing: Text(shop.nursery?.acreage?.value ?? ""),
      ));
    }
    return shopListTiles;
  }
}
