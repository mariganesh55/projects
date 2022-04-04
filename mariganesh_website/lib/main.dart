import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mariganesh_website/routes.dart';

import 'home_screen/bloc/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final PageStorageKey<String> scrollKey = const PageStorageKey('');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //final PageStorageBucket _bucket = PageStorageBucket();

  // This widget is the root of your application.

  var routerDelegate;

  @override
  Widget build(BuildContext context) {
    // routerDelegate = BeamerDelegate(
    //   locationBuilder: RoutesLocationBuilder(
    //     routes: {
    //       // Return either Widgets or BeamPages if more customization is needed
    //       '/': (context, state, data) => HomeScreen(scaffoldKey),
    //       '/projects': (context, state, data) => ProjectsScreen(),
    //     },
    //   ),
    // );
    // return MaterialApp.router(
    //   routeInformationParser: BeamerParser(),
    //   routerDelegate: routerDelegate,
    // );
    return ScreenUtilInit(
      designSize: const Size(3072, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: getRoute,
        home: addAuthBloc(
          context,
          HomeScreen(scaffoldKey),
          // ProjectsScreen()
        ),
      ),
    );
  }
}
