import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mariganesh_website/utils/constants.dart';
import 'package:mariganesh_website/utils/image_resource.dart';
import 'package:mariganesh_website/utils/responsiveness.dart';
import 'package:mariganesh_website/widgets/custom_auto_size_text.dart';
import 'package:mariganesh_website/widgets/custom_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LargeScreen extends StatefulWidget {
  LargeScreen({Key? key}) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  late PageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 200.w),
              child: Row(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(0, 2),
                              color: Colors.white)
                        ],
                        border: Border.all(width: 10),
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(55.r)),
                    width: 620.w,
                    height: 1300.h,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(35.r),
                        child: PageView(
                          controller: controller,
                          children: [
                            Image.asset(
                              ImageResource.pulsedIn,
                              fit: BoxFit.fill,
                            ),
                            Image.asset(
                              ImageResource.oncopower,
                              fit: BoxFit.fill,
                            ),
                            Image.asset(
                              ImageResource.clinirexInfo,
                              fit: BoxFit.fill,
                            ),
                            Image.asset(
                              ImageResource.clinirexChecker,
                              fit: BoxFit.fill,
                            ),
                            Image.asset(
                              ImageResource.markHealth,
                              fit: BoxFit.fill,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          ParellaxWidget(controller: controller),
        ],
      ),
    );
  }
}

class ParellaxWidget extends StatefulWidget {
  const ParellaxWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<ParellaxWidget> createState() => _ParellaxWidgetState();
}

class _ParellaxWidgetState extends State<ParellaxWidget> {
  var top = 0.0;
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (v) {
        if (v is ScrollUpdateNotification) {
          setState(() => top -= v.scrollDelta! / 2);
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
              right: ResponsiveWidget.isMediumScreen(context) ? 1800.w : 1200.w,
              left: 200.w),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: ProjectTextWidget(
                    Constants.pulsedIn, Constants.pulsedInDescription, () {
                  widget.controller.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 500,
              ),
              ProjectTextWidget(
                  Constants.oncopower, Constants.oncopowerDescription, () {
                widget.controller.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height - 500,
              ),
              ProjectTextWidget(
                  Constants.clinirexInfo, Constants.clinirexInfoDescription,
                  () {
                widget.controller.animateToPage(2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height - 500,
              ),
              ProjectTextWidget(Constants.clinirexChecker,
                  Constants.clinirexCheckerDescription, () {
                widget.controller.animateToPage(3,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height - 500,
              ),
              ProjectTextWidget(
                  Constants.markHealth, Constants.markHealthDescription, () {
                widget.controller.animateToPage(4,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height - 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectTextWidget extends StatefulWidget {
  ProjectTextWidget(this.projectTitle, this.projectDescription, this.onVisible,
      {Key? key})
      : super(key: key);

  Function onVisible;
  String projectTitle;
  String projectDescription;

  @override
  _ProjectTextWidgetState createState() => _ProjectTextWidgetState();
}

class _ProjectTextWidgetState extends State<ProjectTextWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _formKey,
      onVisibilityChanged: (info) {
        var visiblePercentage = info.visibleFraction;
        if (mounted) {
          setState(() {
            if (visiblePercentage < 0.9) {
              opacity = 0;
            } else {
              opacity = 1;
              widget.onVisible();
            }
          });
        }
      },
      child: Container(
        // constraints: BoxConstraints(minWidth: 600),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAutoSizeText(
              widget.projectTitle,
              fontSize: 82,
              // maxLines: 2,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            const SizedBox(
              height: 100,
            ),
            CustomText(
              widget.projectDescription,
              fontSize: 72.sp,
              maxLines: 10,
              color: Colors.white,
              // fontWeight: FontWeight.w800,
            )
          ],
        ),
      ),
    );
  }
}
