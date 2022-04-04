import 'package:flutter/material.dart';
import 'package:mariganesh_website/utils/responsiveness.dart';
import 'package:mariganesh_website/widgets/side_menu.dart';
import 'package:mariganesh_website/widgets/top_nav_bar.dart';

import 'large_screen.dart';
import 'medium_screen.dart';
import 'small_screen.dart';

class HomeScreen extends StatefulWidget {
  final PageStorageKey<String> scrollKey = PageStorageKey('');

  // final PageStorageKey<String> scrollKey;
  GlobalKey<ScaffoldState> globalKey;

  HomeScreen(this.globalKey);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.globalKey,
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        // appBar: topNavigationBar(context, widget.globalKey),
        drawer: Drawer(
          child: SideMenu(),
        ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
              [topNavigationBar(context, widget.globalKey)],
          body: ResponsiveWidget(
            largeScreen: LargeScreen(
                // key: widget.scrollKey,
                ),
            mediumScreen: MediumScreen(
                // key: widget.scrollKey,
                ),
            smallScreen: SmallScreen(
                // key: widget.scrollKey,
                ),
            customScreen: Container(
              color: Colors.green,
            ),
          ),
        ));
  }
}
