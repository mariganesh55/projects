import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mariganesh_website/utils/constants.dart';
import 'package:mariganesh_website/utils/image_resource.dart';
import 'package:mariganesh_website/widgets/custom_auto_size_text.dart';
import 'package:mariganesh_website/widgets/custom_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MediumScreen extends StatefulWidget {
  MediumScreen({Key? key}) : super(key: key);

  @override
  _MediumScreenState createState() => _MediumScreenState();
}

class _MediumScreenState extends State<MediumScreen> {

  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: SingleChildScrollView(
            child: ParellaxWidget(),
          ),
        ),
      ),
    );
  }
}

class ParellaxWidget extends StatefulWidget {
  const ParellaxWidget({Key? key}) : super(key: key);

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
          padding: EdgeInsets.only(right: 0, left: 200.w),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    borderRadius: BorderRadius.circular(40)),
                width: 350,
                height: 700,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      ImageResource.pulsedIn,
                      fit: BoxFit.fill,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ProjectTextWidget(
                    Constants.pulsedIn, Constants.pulsedInDescription, () {}),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          color: Colors.white)
                    ],
                    border: Border.all(width: 10),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40)),
                width: 350,
                height: 700,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      ImageResource.oncopower,
                      fit: BoxFit.fill,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: ProjectTextWidget(
                    Constants.oncopower, Constants.oncopowerDescription, () {}),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          color: Colors.white)
                    ],
                    border: Border.all(width: 10),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40)),
                width: 350,
                height: 700,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      ImageResource.clinirexInfo,
                      fit: BoxFit.fill,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: ProjectTextWidget(Constants.clinirexInfo,
                    Constants.clinirexInfoDescription, () {}),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          color: Colors.white)
                    ],
                    border: Border.all(width: 10),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40)),
                width: 350,
                height: 700,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      ImageResource.clinirexChecker,
                      fit: BoxFit.fill,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: ProjectTextWidget(Constants.clinirexChecker,
                    Constants.clinirexCheckerDescription, () {}),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          color: Colors.white)
                    ],
                    border: Border.all(width: 10),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40)),
                width: 350,
                height: 700,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      ImageResource.markHealth,
                      fit: BoxFit.fill,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: ProjectTextWidget(Constants.markHealth,
                    Constants.markHealthDescription, () {}),
              ),
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
  // double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _formKey,
      onVisibilityChanged: (info) {
        // var visiblePercentage = info.visibleFraction;
        // if (mounted) {
        //   setState(() {
        //     if (visiblePercentage < 0.9) {
        //       opacity = 0;
        //     } else {
        //       opacity = 1;
        //       widget.onVisible();
        //     }
        //   });
        // }
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

              color: Colors.white,
              // fontWeight: FontWeight.w800,
            )
          ],
        ),
      ),
    );
  }
}
