import 'package:farmerce_client/modules/auth/login_controller.dart';
import 'package:farmerce_client/modules/auth/login_page.dart';
import 'package:farmerce_client/modules/login_page_design/login_screen.dart';
import 'package:farmerce_client/modules/nursery/create_nursery_page.dart';
import 'package:farmerce_client/modules/profile/profile_page.dart';
import 'package:farmerce_client/widgets/server_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_router.dart';
import 'config/colors.dart';
import 'config/urls.dart';
import 'core/auth_service.dart';
import 'locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'core/urls.dart';
// import 'locator.dart';
import 'dart:io' show Platform;

import 'modules/auth/veriy_otp_page.dart';
import 'modules/home/home_page.dart';
import 'modules/loading/loading_page.dart';
import 'modules/nursery/nursery_list_page.dart';

String localeName = Platform.localeName;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  bool enableSentry = false;

  setUpLocator();
  if (kReleaseMode || enableSentry) {
    await Sentry.init(
      (options) {
        options.dsn = Urls.sentryCDN;
        return options;
      },
      appRunner: () => runApp(
        App(),
      ),
    );
  } else {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print(
          '[${record.loggerName}]:${record.level.name}: ${record.time}: ${record.message}');
    });
    runApp(const App());
  }
}

class App extends StatelessWidget {
  final Widget? widget;

  const App({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: getIt<GlobalKey<ScaffoldMessengerState>>(),
      navigatorObservers: [SentryNavigatorObserver()],
      theme: ThemeData(
        scaffoldBackgroundColor: C.cream,
        primaryColor: C.darkBlue,
        backgroundColor: C.lightGrey,
        fontFamily: "Public Sans",
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: C.cream),
          fillColor: C.darkBlue,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: C.darkBlue),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: C.darkBlue, width: 2.0)),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: C.darkBlue,
            side: const BorderSide(
                color: C.darkBlue, width: 2, style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: C.darkBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      onGenerateRoute: getIt<AppRouter>().onGenerateRoute,
      getPages: [
        GetPage(name: '/', page: () => LoadingPage()),
        GetPage(
            name: '/root',
            page: () => getIt<AuthService>().gUserData.value.userProfile == null
                ? LoginPage()
                : HomePage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/verifyOTP', page: () => VerifyOTP()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/shop_list_page', page: () => ShopListPage()),
        GetPage(name: '/create_nursery_page', page: () => CreateNurseryPage()),
        GetPage(name: '/server_switcher', page: () => ServerPickerPage()),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
