import 'package:flutter/material.dart';

class FarmerceLogo extends StatelessWidget {
  const FarmerceLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Image.asset(
            'assets/images/logo_leaf.png',
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        ),
        Flexible(
          flex: 1,
          child: Image.asset(
            'assets/images/logo_name.png',
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
      ],
    );
  }
}
