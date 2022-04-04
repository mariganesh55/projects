import 'package:farmerce_client/l10n/l10n.dart';
import 'package:farmerce_client/modules/auth/login_controller.dart';
import 'package:farmerce_client/widgets/background.dart';
import 'package:farmerce_client/widgets/call_for_help.dart';
import 'package:farmerce_client/widgets/farmerce_logo.dart';
import 'package:farmerce_client/widgets/server_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:get/get.dart';
import 'package:flutterfire_ui/src/auth/validators.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(
      LoginController(),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BackgroundImage(
        child: GetBuilder<LoginController>(
          builder: (logic) {
            if (logic.status.isError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                          logic.status.errorMessage ?? "Something went wrong")),
                  TextButton(
                      onPressed: () {
                        logic.retryLogin();
                      },
                      child: Text(lo(context).retry)),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TODO: get one logo rather than leaf and text
                const FarmerceLogo(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PhoneInputCard(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const CallForHelp(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: ServerSwitcher(),
    );
  }
}

class PhoneInputCard extends StatefulWidget {

  const PhoneInputCard({Key? key}) : super(key: key);

  @override
  State<PhoneInputCard> createState() => _PhoneInputCardState();
}

class _PhoneInputCardState extends State<PhoneInputCard> {
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<LoginController>();
    final l = FlutterFireUILocalizations.labelsOf(context);
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: formKey,
                child: TextFormField(
                  autofillHints: const [
                    AutofillHints.telephoneNumberNational
                  ],
                  controller: logic.phoneNoController,
                  onSaved: (value) => logic.phoneNoController.text,
                  validator: Validator.validateAll([
                    NotEmpty(l.phoneNumberIsRequiredErrorText),
                    PhoneValidator(l.phoneNumberInvalidErrorText),
                  ]),
                  decoration: InputDecoration(
                    hintText: lo(context).mobileNumber,
                    prefixIcon: const Padding(
                        padding: EdgeInsets.all(14), child: Text('+91')),
                    suffixIcon: IconButton(
                      onPressed: () {
                        logic.phoneNoController.clear();
                        formKey.currentState?.reset();
                      },
                      icon: const Icon(
                        CupertinoIcons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Icon(CupertinoIcons.paperplane),
                  ),
                  Text(
                    lo(context).sendOTP,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  logic.firebaseOTPAuth();
                }
              },
            ),
          ),
          if (logic.status.isLoading)
            const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
