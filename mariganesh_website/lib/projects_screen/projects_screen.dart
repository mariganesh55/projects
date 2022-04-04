import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariganesh_website/utils/responsiveness.dart';

import 'large_screen.dart';
import 'medium_screen.dart';
import 'small_screen.dart';

class ProjectsScreen extends StatefulWidget {
  ProjectsScreen({Key? key}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //key: widget.globalKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [],
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
