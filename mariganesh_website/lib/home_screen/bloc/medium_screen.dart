import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariganesh_website/utils/app_utils.dart';
import 'package:mariganesh_website/utils/color_resource.dart';
import 'package:mariganesh_website/utils/constants.dart';
import 'package:mariganesh_website/utils/image_resource.dart';
import 'package:mariganesh_website/utils/string_resource.dart';
import 'package:mariganesh_website/widgets/custom_fade_animated_container.dart';
import 'package:mariganesh_website/widgets/custom_text.dart';
import 'package:mariganesh_website/widgets/onhover.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MediumScreen extends StatefulWidget {
  MediumScreen({Key? key}) : super(key: key);

  @override
  _MediumScreenState createState() => _MediumScreenState();
}

class _MediumScreenState extends State<MediumScreen>
    with SingleTickerProviderStateMixin {
  double opacity = 0.0;
  CarouselController carouselController = CarouselController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int flutterPercentage = 0;
  int swiftPercentage = 0;
  int gitPercentage = 0;
  int jiraPercentage = 0;
  int appstorePercentage = 0;
  int playstorePercentage = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  _updatePercentage() {
    if (mounted) {
      setState(() {
        flutterPercentage += 95;
        swiftPercentage += 90;
        gitPercentage += 80;
        jiraPercentage += 80;
        appstorePercentage += 80;
        playstorePercentage += 75;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: RawScrollbar(
          thumbColor: ColorResource.primaryBlue,
          radius: const Radius.circular(50),
          thickness: 8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(top: 100),
                    child: Image.asset(
                      ImageResource.mariganeshLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Center(
                  child: CustomText(
                    Constants.myName,
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Center(
                  child: CustomText(
                    Constants.myDesination,
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Center(
                  child: CustomText(
                    StringResource.myOrigin,
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 100.0, horizontal: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 900,
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.all(40),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(450),
                                  topRight: Radius.circular(450),
                                  bottomLeft: Radius.circular(450),
                                  bottomRight: Radius.circular(450))),
                          child: Container(
                            height: 900,
                            width: double.infinity,
                            child: Image.asset(
                              ImageResource.profilePic,
                              fit: BoxFit.cover,
                            ),
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(450),
                                    topRight: Radius.circular(450),
                                    bottomLeft: Radius.circular(450),
                                    bottomRight: Radius.circular(450))),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // biography widget

                          CustomFadeAnimatedContainer(Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                StringResource.bioGraphy,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 50.0, bottom: 50, right: 150),
                                child: CustomText(
                                    StringResource.bioGraphyDescription,
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 2),
                              ),
                            ],
                          )),

                          // contact widget

                          CustomFadeAnimatedContainer(Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                StringResource.contact,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 50.0, bottom: 50, right: 150),
                                child: Column(
                                  children: [
                                    CustomText(Constants.address,
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        lineHeight: 2),
                                  ],
                                ),
                              ),
                            ],
                          )),

                          //service widget

                          CustomFadeAnimatedContainer(Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                StringResource.services,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 50.0, bottom: 50, right: 150),
                                child: CustomText(
                                    StringResource
                                        .mobileApplicationDevelopement,
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 2),
                              ),
                            ],
                          )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // years of experience widget

                          CustomFadeAnimatedContainer(Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                StringResource.yearsOfExperience,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 50.0, bottom: 50),
                                child: CustomText(Constants.yearsOfExperience,
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 2),
                              ),
                            ],
                          )),

                          // total project widget

                          CustomFadeAnimatedContainer(Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                StringResource.projectsDone,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 50.0, bottom: 50),
                                child: Column(
                                  children: [
                                    CustomText(Constants.totalProjects,
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        lineHeight: 2),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      // width: 200,
                      // height: 150,
                      child: OnHover(builder: (isHovered) {
                        return Image.asset(
                          ImageResource.hcl,
                          fit: BoxFit.fill,
                        );
                      }),
                    ),
                    Expanded(
                      child: OnHover(builder: (isHovered) {
                        return Container(
                          // margin: const EdgeInsets.symmetric(
                          //   horizontal: 100,
                          // ),
                          padding: const EdgeInsets.only(top: 40),
                          // width: 200,
                          // height: 150,
                          child: Image.asset(
                            ImageResource.tartLabs,
                            fit: BoxFit.fill,
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      // width: 300,
                      // height: 100,
                      child: OnHover(builder: (isHovered) {
                        return Image.asset(
                          ImageResource.m2p,
                          fit: BoxFit.fill,
                        );
                      }),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 100, bottom: 100, left: 100, right: 100),
                  height: 1,
                  color: Colors.black,
                ),
                _buildMyAdvantage(),
                _buildMyEducationAndWorkExperience(),
                _buildRewards(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Row(
                    children: [
                      CustomText(
                        "© 2021 mariganesh. All Rights Reserved.",
                        fontSize: 18,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Center(
                            child: OnHover(builder: (isHovered) {
                              return GestureDetector(
                                onTap: () {
                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'mariganeshthangam@gmail.com',
                                  );
                                  AppUtils.launchURL(emailLaunchUri.toString());
                                },
                                child: Center(
                                  child: AutoSizeText(
                                    Constants.mailId,
                                    style: TextStyle(
                                        color: isHovered
                                            ? Colors.orange
                                            : Colors.black,
                                        fontSize: 18),
                                    maxLines: 1,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyAdvantage() {
    return VisibilityDetector(
      key: _formKey,
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction;

        if (visiblePercentage > 0 && flutterPercentage == 0) {
          _updatePercentage();
        }
      },
      child: Column(
        children: [
          CustomText(
            StringResource.myAdvantage,
            fontSize: 54,
            fontWeight: FontWeight.w400,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 150, bottom: 100, left: 100, right: 100),
            child: Wrap(
              runSpacing: 50,
              children: [
                _buildMyAdvantageWidget(
                    StringResource.flutter,
                    flutterPercentage,
                    ImageResource.flutterColor,
                    ImageResource.flutter),
                _buildMyAdvantageWidget(StringResource.swift, swiftPercentage,
                    ImageResource.swiftColor, ImageResource.swift),
                _buildMyAdvantageWidget(StringResource.git, gitPercentage,
                    ImageResource.gitColor, ImageResource.git),
                _buildMyAdvantageWidget(StringResource.jira, jiraPercentage,
                    ImageResource.jiraColor, ImageResource.jira),
                _buildMyAdvantageWidget(
                    StringResource.appStore,
                    appstorePercentage,
                    ImageResource.appstoreColor,
                    ImageResource.appstore),
                _buildMyAdvantageWidget(
                    StringResource.playStore,
                    playstorePercentage,
                    ImageResource.playstoreColor,
                    ImageResource.playstore),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 100, bottom: 100, left: 100, right: 100),
            height: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildMyAdvantageWidget(String skillName, int skillPercentage,
      String selectedIcon, String unselectedIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          OnHover(
            builder: (isHovered) {
              return Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(150))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(isHovered ? selectedIcon : unselectedIcon),
                    SizedBox(
                      height: 8,
                    ),
                    AnimatedFlipCounter(
                      value: skillPercentage,
                      fractionDigits: 2, // decimal precision
                      suffix: " %",
                      textStyle: GoogleFonts.sourceSansPro(
                        color: Colors.black,
                        fontSize: 38,
                        fontWeight: FontWeight.w400,
                      ),

                      duration: Duration(seconds: 2),
                    )
                  ],
                ),
              );
            },
            onHoverFunction: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomText(
              skillName,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMyEducationAndWorkExperience() {
    return Column(
      children: [
        CustomText(
          StringResource.educationAndExperience,
          fontSize: 54,
          fontWeight: FontWeight.w400,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150, bottom: 100, left: 100),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: CustomText(
                        "2017",
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                    _buildEducationWidget("Bachelor of Engineering",
                        "National Engineering College")
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: CustomText(
                        "2017 - 2021",
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: _buildEducationWidget(
                          "Associate Software Engineer", "HCL Technologies"),
                    ),
                    _buildEducationWidget("Software Engineer", "TartLabs"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: CustomText(
                        "2021 - present",
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                    _buildEducationWidget(
                        "Senior Software Engineer", "M2P Fintech")
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              top: 100, bottom: 100, left: 100, right: 100),
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildEducationWidget(String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontSize: 30,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CustomText(
            subtitle,
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRewards() {
    return Column(
      children: [
        CustomText(
          StringResource.rewards,
          fontSize: 54,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 100,
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    carouselController.previousPage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 60,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      // height: 200.0,
                      aspectRatio: 2.5,
                      enableInfiniteScroll: true,
                      pauseAutoPlayOnTouch: true,
                      autoPlayInterval: Duration(seconds: 8),
                      autoPlay: true,
                      viewportFraction: 1),
                  items: [1, 2].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            // margin: EdgeInsets.symmetric(horizontal: 100.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AutoSizeText(
                                  i == 1
                                      ? StringResource.hclFeedback
                                      : StringResource.tartLabsFeedback,
                                  style: GoogleFonts.sourceSansPro(
                                    color: Colors.black,
                                    // fontFamily: widget.font.value,
                                    fontSize: 32,
                                  ),
                                  maxLines: i == 1 ? 3 : 4,
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                CustomText(
                                  i == 1 ? "HCL Technologies" : "TartLabs",
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ));
                      },
                    );
                  }).toList(),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    carouselController.nextPage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 60,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              top: 100, bottom: 100, left: 100, right: 100),
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
