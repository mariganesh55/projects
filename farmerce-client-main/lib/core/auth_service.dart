import 'dart:async';

import 'package:farmerce_client/graphql/user.data.gql.dart';
import 'package:farmerce_client/graphql/user.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../client.dart';
import '../locator.dart';

Future<AuthService> initAuthService() async {
  final AuthService authService = AuthService();
  var user = getIt<FirebaseAuth>().currentUser;
  if (user != null) {
    final token = await getIt<FirebaseAuth>().currentUser?.getIdToken();
    if (token != null) {
      await clientWithToken(token);
      await getIt.isReady<Client>();
      final orStream = await authService.serverAuth();
      final or = await orStream.first;
      if (or.data != null) {
        authService.gUserData.value = or.data;
        authService.tokenListener();
      }
    }
  }
  return authService;
}

class AuthService {
  var gUserData = GUserData().obs;
  bool isTokenClient = false;

  // String? token;
  StreamSubscription? _subscription;

  AuthService() {
    // _tokenListener();
  }

  void logout() async {
    await getIt<FirebaseAuth>().signOut();
    gUserData.value = GUserData();
    // token = null;
    Get.offAndToNamed('/root');
  }

  void tokenListener() async {
    _subscription = getIt<FirebaseAuth>().idTokenChanges().listen((user) async {
      if (user == null) return;
      final token = await user.getIdToken();
      await clientWithToken(token);
    });
  }

  // run in loading view

  Future<Stream<OperationResponse>> serverAuth() async {
    final userReq = GUserReq((b) => b..fetchPolicy = FetchPolicy.NoCache);
    final res = getIt<Client>().request(userReq);
    return res;
  }
}
