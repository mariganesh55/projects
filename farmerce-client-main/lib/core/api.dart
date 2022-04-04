// import 'package:farmerce_client/config/urls.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
//
// import '../locator.dart';
//
// Future<Api> initApi() async {
//   Api api = Api();
//   return api;
// }
//
// class Api {
//   String? token;
//   Uri url = Uri.parse(getIt<Urls>().serverUrl);
//
//   Api() {
//     _tokenListener();
//   }
//
//   void _tokenListener() {
//     getIt<FirebaseAuth>().idTokenChanges().listen((user) async {
//       if (user == null) return;
//       token = await user.getIdToken();
//     });
//   }
//
//   Future<http.Response> post(Map body) async {
//     print(body);
//     var response = await http.post(
//       url,
//       body: body,
//       headers: {"Authorization": "$token"},
//     );
//     return response;
//   }
// }
