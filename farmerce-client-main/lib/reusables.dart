import 'package:flutter/material.dart';

import 'l10n/l10n.dart';

Widget backgroundImage(BuildContext context) {
  return Image.asset(
    'assets/images/background_leaves.png',
    repeat: ImageRepeat.repeat,
    // fit: BoxFit.fill,
  );
}

Widget buttonOTP(BuildContext context, String text, Widget page) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.35,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/icon_send.png',
              width: MediaQuery.of(context).size.height * 0.02,
              height: MediaQuery.of(context).size.height * 0.02),
          Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => page));
      },
    ),
  );
}

Widget helpGroup(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.04,
      ),
      // Text Did't receive code?
      Text(
        lo(context).didNotReceiveOTP,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.of(context).size.height * 0.025,
          color: Colors.black,
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      ),
      // Call for help button
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).scaffoldBackgroundColor,
            onPrimary: Theme.of(context).primaryColor,
            side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
                style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.4,
              MediaQuery.of(context).size.height * 0.06,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/images/icon_phone.png',
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.height * 0.05),
            Text(
              lo(context).callForHelp,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ],
  );
}
