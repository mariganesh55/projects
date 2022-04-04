import 'package:farmerce_client/l10n/l10n.dart';
import 'package:farmerce_client/reusables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPPage extends StatefulWidget {
  OTPPage({Key? key, required this.phone}) : super(key: key);
  String phone;
  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          lo(context).signUpTo,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          backgroundImage(context),
          Column(
            children: [
              Image.asset(
                'assets/images/enter_otp.png',
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.35,
                child: otpBoxContent(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
              helpGroup(context),
            ],
          ),
        ],

      ),
    );
  }

  Widget otpBoxContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.07,
          top: MediaQuery.of(context).size.height * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lo(context).mobileNumber,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              fontFamily: 'Public Sans',
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Row(
            children: [
              Text(
                widget.phone,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.09),
              InkWell(
                //Todo: Edit this to make it to go to previous page
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                  size: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            lo(context).enterOTP,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              fontFamily: 'Public Sans',
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          // Add textFields
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _otpTextField(context, digit: 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              _otpTextField(context, digit: 1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              _otpTextField(context, digit: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              _otpTextField(context, digit: 3),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                fixedSize: Size(
                  MediaQuery.of(context).size.width * 0.4,
                  MediaQuery.of(context).size.height * 0.06,
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icon_send.png',
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Text(lo(context).resendOTP),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _otpTextField(BuildContext context, {required int digit}) {
    return Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: Text(
        digit.toString(),
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.04,
          fontFamily: 'Public Sans',
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(214, 214, 214, 1),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
