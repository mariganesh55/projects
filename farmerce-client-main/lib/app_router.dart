import 'package:farmerce_client/modules/auth/login_controller.dart';
import 'package:farmerce_client/widgets/server_switcher.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'core/auth_service.dart';
import 'locator.dart';
import 'modules/auth/login_page.dart';
import 'modules/auth/veriy_otp_page.dart';
import 'modules/home/home_page.dart';
import 'modules/loading/loading_page.dart';

class AppRouter {
  final _log = Logger("AppRouter");
  static Map<String, Widget> routes = {
    '/': const LoadingPage(),
    '/home': const HomePage(),
    '/login': const LoginPage(),
    '/verifyOTP': const VerifyOTP(),
    '/server_switcher_page': const ServerSwitcher(),
  };

  Route? onGenerateRoute(RouteSettings settings) {
    String? route = settings.name;

    if (route == null) return null;
    _log.info("Route: $route");
    if (route != '/') {
      if (getIt<AuthService>().gUserData == null) {
        route = '/login';
        _log.info("not logged in, force route -> $route");
      }
    }
    Widget? child = AppRouter.routes[route];
    if (child == null) {
      _log.warning(
        "Cannot not resolve which widget to build for the route: '$route'",
      );
      return null;
    }
    return MaterialPageRoute(builder: (context) => child);
  }
}
