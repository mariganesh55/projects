import 'package:farmerce_client/modules/auth/login_controller.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'config/urls.dart';
import 'locator.dart';
import 'package:http/http.dart' as http;

Future<Cache> initCache() async {
  final appDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDir.path);
  final box = await Hive.openBox("graphql");
  // await box.clear();
  final store = HiveStore(box);
  return Cache(store: store);
}
// http.Client initHttpClient(){
//   return http.Client(Uri.parse());
// }

Future<Client> clientWithOutToken() async {
  var token = await getIt<FirebaseAuth>().currentUser?.getIdToken();
  final link = HttpLink(getIt<Urls>().serverUrl,
      defaultHeaders: {"Authorization": "$token}"});
  final client = Client(
    link: link,
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.NoCache,
      OperationType.mutation: FetchPolicy.NoCache
    },
    cache: getIt<Cache>(),
  );
  return client;
}

Future<void> clientWithToken(idToken) async {
  if (getIt.isRegistered<Client>()) {
    await getIt.unregister<Client>();
  }
  await getIt.isReady<Cache>();
  final link = HttpLink(getIt<Urls>().serverUrl,
      defaultHeaders: {"Authorization": "$idToken"});
  final client = Client(
    link: link,
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.NoCache,
      OperationType.mutation: FetchPolicy.NoCache
    },
    cache: getIt<Cache>(),
  );

  getIt.registerSingleton<Client>(client, signalsReady: true);
  getIt.signalReady(client);
}
