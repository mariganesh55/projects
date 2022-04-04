import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';

Future<Urls> initUrls() async {
  Urls urls = Urls();
  final sharedPreferences = getIt<SharedPreferences>();
  final selectedServerKey = sharedPreferences.getString(Urls.prefKey);
  if (selectedServerKey == null) {
    await sharedPreferences.setString(
        Urls.prefKey, Urls.defaultServerKey.value);
  } else {
    Urls.defaultServerKey.value = selectedServerKey;
  }
  return urls;
}

class Urls {
  // final $ = Logger("Urls");
  static final String prefKey = "selectedServerKey";

  static String get sentryCDN =>
      "https://cf61d778def646c0be9096073d9e3d13@o140713.ingest.sentry.io/5869936";
  static var defaultServerKey = "test".obs;

  String get serverUrl => serverChoices[defaultServerKey];

  /// if no url is passed returns host of serverUrl
  String getServerString([String? fullUrl]) {
    String url = fullUrl ?? serverUrl;
    Uri uri = Uri.parse(url);
    return uri.host;
  }

  Future<bool> saveServer() =>
      getIt<SharedPreferences>().setString(prefKey, defaultServerKey.value);

  /// choices for SelectServer view
  static final serverChoices = Map.from(
    {
      "prod": "https://farmerce.in/graphql/",
      "test": "https://test.farmerce.in/graphql/",
      "localhost": "http://localhost:8000/graphql/",
      "ngrok": "https://e6fa-45-118-157-64.ngrok.io/graphql/",
    },
  );
}
