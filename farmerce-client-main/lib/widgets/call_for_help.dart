import 'package:farmerce_client/config/colors.dart';
import 'package:farmerce_client/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallForHelp extends StatelessWidget {
  const CallForHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset('assets/images/icon_phone.png',
          //     width: MediaQuery.of(context).size.width * 0.05,
          //     height: MediaQuery.of(context).size.height * 0.05),
          const Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: Icon(
              CupertinoIcons.phone_arrow_up_right,
            ),
          ),
          Text(
            lo(context).callForHelp,
            // style: TextStyle(
            //   // fontWeight: FontWeight.w500,
            //   // fontSize: MediaQuery.of(context).size.height * 0.025,
            // ),
          ),
        ],
      ),
    );
  }
}
