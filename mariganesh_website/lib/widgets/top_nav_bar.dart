import 'package:flutter/material.dart';
import 'package:mariganesh_website/projects_screen/projects_screen.dart';
import 'package:mariganesh_website/utils/app_utils.dart';
import 'package:mariganesh_website/utils/color_resource.dart';
import 'package:mariganesh_website/utils/constants.dart';
import 'package:mariganesh_website/utils/image_resource.dart';
import 'package:mariganesh_website/utils/responsiveness.dart';
import 'package:mariganesh_website/utils/string_resource.dart';
import 'package:mariganesh_website/widgets/onhover.dart';

import 'custom_text.dart';

SliverAppBar topNavigationBar(
        BuildContext context, GlobalKey<ScaffoldState> key) =>
    SliverAppBar(
      floating: true,
      leading: ResponsiveWidget.isLargeScreen(context)
          ? Container()
          : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                key.currentState?.openDrawer();
              }),
      title: Row(
        children: [
          Visibility(
              visible: ResponsiveWidget.isLargeScreen(context),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    OnHover(
                      builder: (isHovered) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: CustomText(
                            StringResource.home,
                            color: isHovered ? Colors.orange : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    OnHover(
                      builder: (isHovered) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectsScreen(),
                                ));
                            // Navigator.pushNamed(
                            //     context, AppRoutes.projectScreen);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: CustomText(
                              StringResource.projects,
                              color: isHovered ? Colors.orange : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    // OnHover(
                    //   builder: (isHovered) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    //       child: CustomText(
                    //         StringResource.blog,
                    //         color: isHovered ? Colors.orange : Colors.black,
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     );
                    //   },
                    // ),
                    // OnHover(
                    //   builder: (isHovered) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    //       child: CustomText(
                    //         StringResource.pages,
                    //         color: isHovered ? Colors.orange : Colors.black,
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              )),
          Expanded(
              child: Container(
                  // child: Center(
                  //   child: Container(
                  //     width: 100,
                  //     height: 50,
                  //     margin: const EdgeInsets.only(top: 10),
                  //     child: Image.asset(ImageResource.mariganeshLogo),
                  //   ),
                  // ),
                  )),
          Padding(
            padding: EdgeInsets.only(
                top: ResponsiveWidget.isSmallScreen(context) ? 0 : 30),
            child: Row(
              children: [
                OnHover(
                  builder: (isHovered) {
                    return GestureDetector(
                      onTap: () {
                        AppUtils.launchURL(Constants.twitterLink);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            ImageResource.twitter,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                OnHover(
                  builder: (isHovered) {
                    return GestureDetector(
                      onTap: () {
                        AppUtils.launchURL(Constants.facebookLink);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveWidget.isSmallScreen(context)
                                ? 30
                                : 40.0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            ImageResource.facebook,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                OnHover(
                  builder: (isHovered) {
                    return GestureDetector(
                      onTap: () {
                        AppUtils.launchURL(Constants.instaLink);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveWidget.isSmallScreen(context)
                                ? 30
                                : 40.0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            ImageResource.instagram,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                OnHover(
                  builder: (isHovered) {
                    return GestureDetector(
                      onTap: () {
                        AppUtils.launchURL(Constants.linkedInLink);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveWidget.isSmallScreen(context)
                                ? 30
                                : 40.0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            ImageResource.linkedin,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

showMenus(BuildContext context) async {
  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(0, 100, 100, 100),
    items: [
      PopupMenuItem(
        child: Text("View"),
      ),
      PopupMenuItem(
        child: Text("Edit"),
      ),
      PopupMenuItem(
        child: Text("Delete"),
      ),
    ],
  );
}
