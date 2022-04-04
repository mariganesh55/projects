import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariganesh_website/projects_screen/projects_screen.dart';
import 'package:mariganesh_website/utils/color_resource.dart';
import 'package:mariganesh_website/widgets/onhover.dart';

import 'custom_text.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black,
      child: ListView(
        children: [
          // if (ResponsiveWidget.isSmallScreen(context))
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  SizedBox(width: _width / 48),
                  OnHover(
                    builder: (isHovered) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.all(18),
                        child: CustomText(
                          "Home",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isHovered
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 36),
                  ),
                  OnHover(
                    builder: (isHovered) => GestureDetector(
                      onTap: () {
                        // Beamer.of(context).beamToNamed('/projects');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectsScreen(),
                            ));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.all(18),
                        child: CustomText(
                          "Projects",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isHovered
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 36),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: sideMenuItemRoutes
          //       .map((item) => SideMenuItem(
          //           itemName: item.name,
          //           onTap: () {
          //             if (item.route == authenticationPageRoute) {
          //               Get.offAllNamed(authenticationPageRoute);
          //               menuController
          //                   .changeActiveItemTo(overviewPageDisplayName);
          //             }
          //             if (!menuController.isActive(item.name)) {
          //               menuController.changeActiveItemTo(item.name);
          //               if (ResponsiveWidget.isSmallScreen(context)) Get.back();
          //               navigationController.navigateTo(item.route);
          //             }
          //           }))
          //       .toList(),
          // )
        ],
      ),
    );
  }
}
