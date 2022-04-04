import 'package:ferry/ferry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_router.dart';
import 'client.dart';
import 'config/urls.dart';
import 'core/auth_service.dart';

final getIt = GetIt.instance;

setUpLocator() {
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerSingletonAsync<Cache>(() => initCache());
  getIt.registerSingletonAsync<Urls>(() => initUrls(),
      dependsOn: [SharedPreferences]);

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // getIt.registerSingletonAsync<Client>(
  //   () => clientWithOutToken(),
  //   dependsOn: [Cache, Urls],
  // );
  getIt
      .registerSingletonAsync<AuthService>(() => initAuthService(), dependsOn: [
    Urls,
  ]);

  // getIt.registerSingletonAsync<Api>(
  //   () => initApi(),
  //   dependsOn: [Urls],
  // );

  // getIt.registerSingletonWithDependencies(() => AuthService(),
  //     dependsOn: [Client]);
  //
  getIt.registerLazySingletonAsync<PackageInfo>(
      () => PackageInfo.fromPlatform());

  getIt.registerLazySingleton<GlobalKey<ScaffoldMessengerState>>(
      () => GlobalKey<ScaffoldMessengerState>());
}
