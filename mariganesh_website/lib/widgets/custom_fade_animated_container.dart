import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CustomFadeAnimatedContainer extends StatefulWidget {
  Widget widget;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CustomFadeAnimatedContainer(this.widget);

  @override
  _CustomFadeAnimatedContainerState createState() =>
      _CustomFadeAnimatedContainerState();
}

class _CustomFadeAnimatedContainerState
    extends State<CustomFadeAnimatedContainer> {
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget._formKey,
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction;
        if (mounted) {
          setState(() {
            opacity = visiblePercentage;
          });
        }
      },
      child: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 1000),
        child: widget.widget,
        curve: Curves.easeIn,
      ),
    );
  }
}
