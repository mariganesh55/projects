
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;

  const BackgroundImage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_leaves.png',
              repeat: ImageRepeat.repeat,
            ),
          ),
          child,
        ],
      ),
    );
  }
}