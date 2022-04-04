import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mariganesh_website/home_screen/bloc/home_bloc.dart';
import 'package:mariganesh_website/projects_screen/bloc/projects_bloc.dart';
import 'package:mariganesh_website/projects_screen/projects_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'home_screen/bloc/home_screen.dart';

class AppRoutes {
  static const String homeScreen = "home_screen";
  //static const String projectScreen = 'projects_screen';
}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.homeScreen:
      return buildHomeScreen();
    // case AppRoutes.projectScreen:
    //   return buildProjectsScreen();
  }
  return buildHomeScreen();
}

Route<dynamic> buildHomeScreen() {
  return MaterialPageRoute(builder: (context) {
    return addAuthBloc(context, PageBuilder.buildHomeScreen());
  });
}

// Route<dynamic> buildProjectsScreen() {
//   return MaterialPageRoute(builder: (context) {
//     return addAuthBloc(context, PageBuilder.buildProjectsScreen());
//   });
// }

class PageBuilder {
  static Widget buildHomeScreen() {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (BuildContext context) => BlocProvider.of<HomeBloc>(context),
      child: HomeScreen(scaffoldKey),
    );
  }

  // static Widget buildProjectsScreen() {
  //   return BlocProvider(
  //     create: (BuildContext context) => BlocProvider.of<ProjectsBloc>(context),
  //     child: ProjectsScreen(),
  //   );
  // }
}

Widget addAuthBloc(BuildContext context, Widget widget) {
  final PageStorageBucket _bucket = PageStorageBucket();
  const PageStorageKey<String> scrollKey = PageStorageKey('');
  return ResponsiveWrapper.builder(
    PageStorage(
      bucket: _bucket,
      child: widget,
      key: scrollKey,
    ),
    // maxWidth: 1000\

    minWidth: 480,
    defaultScale: true,

    breakpoints: const [
      ResponsiveBreakpoint.resize(480, name: MOBILE),
      ResponsiveBreakpoint.autoScale(800, name: TABLET),
      ResponsiveBreakpoint.resize(1000, name: DESKTOP),
    ],
    background: Container(color: const Color(0xFFF5F5F5)),
  );
}
