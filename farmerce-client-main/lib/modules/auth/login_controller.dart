import 'dart:async';
import 'package:farmerce_client/core/auth_service.dart';
import 'package:farmerce_client/graphql/user.data.gql.dart';
import 'package:farmerce_client/graphql/user.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logging/logging.dart';

import '../../client.dart';
import '../../locator.dart';

class LoginController extends GetxController with StateMixin<GUserData> {
  AuthService authService = getIt<AuthService>();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  StreamSubscription? _subscription;

  String get phoneNumber => '+91${phoneNoController.text}';

  String get otp => otpController.text;

  final _log = Logger('LoginController');

  String? firebaseVerificationId;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
    // serverAuth();
  }

  void retryLogin() {
    change(null, status: RxStatus.empty());
  }

  Future<void> serverAuth() async {
    String? uid = getIt<FirebaseAuth>().currentUser?.uid;
    if (uid == null) {
      change(null, status: RxStatus.error("Firebase not authenticated"));
      return;
    }
    final token = await getIt<FirebaseAuth>().currentUser?.getIdToken();
    await clientWithToken(token);
    await getIt.isReady<Client>();
    final orStream = await authService.serverAuth();
    _subscription = orStream.listen((or) {
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
      _log.fine("serverUser: ${or.data}");
      getIt<Cache>().writeQuery(GUserReq(), or.data);
      GUserData? userData = or.data;
      if (userData == null) return;
      authService.gUserData.value = userData;
      authService.tokenListener();
      change(userData, status: RxStatus.success());
      Get.offAllNamed('/root');
      _subscription?.cancel();
    });
  }

  Future<void> firebaseOTPAuth() async {
    change(null, status: RxStatus.loading());
    await getIt<FirebaseAuth>().verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        final userCredential =
            await getIt<FirebaseAuth>().signInWithCredential(credential);

        final idToken = await userCredential.user?.getIdToken();
        if (idToken == null) {
          return;
        }
        // getIt<Cache>().store.put("token", {'idToken': idToken});
        serverAuth();
      },
      verificationFailed: (FirebaseAuthException e) {
        change(null, status: RxStatus.error(e.message));
      },
      codeSent: (String verificationId, int? resendToken) {
        firebaseVerificationId = verificationId;
        Get.toNamed('/verifyOTP');
        change(null, status: RxStatus.empty());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    change(null, status: RxStatus.loading());
    var verificationId = firebaseVerificationId;
    if (verificationId == null) {
      change(null,
          status: RxStatus.error("Cant find verification id & smsCode"));
      return;
    }
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    // next time login will different otp
    otpController.clear();
    // Sign the user in (or link) with the credential
    UserCredential? userCredential;
    try {
      userCredential =
          await getIt<FirebaseAuth>().signInWithCredential(credential);
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      return;
    }
    var uid = userCredential.user?.uid;
    if (uid != null) {
      serverAuth();
    } else {
      change(null, status: RxStatus.error("Cant find uid"));
      return;
    }
  }
}
