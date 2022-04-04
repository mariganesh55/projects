import 'package:farmerce_client/l10n/l10n.dart';
import 'package:farmerce_client/modules/login_page_design/otp_page.dart';
import 'package:farmerce_client/reusables.dart';
import 'package:farmerce_client/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/**
 * Todo Specifics: Add fonts, 
 * decrese images size(Have to remove white spaces)
 * Add fonts and fix Ui elements
 */

class LoginPageDesign extends StatefulWidget {

  const LoginPageDesign({Key? key}) : super(key: key);

  @override
  State<LoginPageDesign> createState() => _LoginPageDesignState();
}

class _LoginPageDesignState extends State<LoginPageDesign> {
  final TextEditingController _phoneController = TextEditingController();
  late String phone;
  @override
  void initState() {
    // TODO 0: Fix the names and optimise the login below
    _phoneController.addListener(() {
      phone = _phoneController.text;
      _phoneController.value.copyWith(
        selection:
            TextSelection(baseOffset: phone.length, extentOffset: phone.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // TODO 1: Move these colors, Widths and Heights to a variable for refactoring
      backgroundColor: Theme.of(context).backgroundColor,
      body: BackgroundImage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset('assets/images/logo_leaf.png',
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.15),
                ),
                Flexible(
                  flex: 1,
                  child: Image.asset('assets/images/logo_name.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0004,
            ),
            loginBox(context),
            helpGroup(context),
            loginSignGroup(context),
          ],
        ),
      ),
    );
  }

  Container loginBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, 4),
            blurRadius: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: lo(context).mobileNumber,
                hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
                contentPadding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          // TODO 2: Add logic for empty strings and incorrect phone number
          buttonOTP(
              context,
              lo(context).sendOTP,
              OTPPage(
                phone: _phoneController.text,
              ))
        ],
      ),
    );
  }

  Column loginSignGroup(BuildContext context) {
    // TODO 3 : Logic on truecaller button
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Truecaller Button
        TextButton(
          style: TextButton.styleFrom(
            // Static color, single use
            backgroundColor: const Color.fromRGBO(20, 124, 251, 1),
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.6,
              MediaQuery.of(context).size.height * 0.06,
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_truecaller.png',
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1),
              Text(
                lo(context).loginWithTrueCaller,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextButton(
          // Sign up button
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.6,
              MediaQuery.of(context).size.height * 0.06,
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/icon_add_user.png',
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1),
              Text(
                lo(context).signUp,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.white),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
