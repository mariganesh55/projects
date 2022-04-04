import 'package:farmerce_client/config/colors.dart';
import 'package:farmerce_client/l10n/l10n.dart';
import 'package:farmerce_client/widgets/server_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<LoginController>(
          builder: (logic) {
            if (logic.status.isError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(logic.status.errorMessage ??
                        lo(context).somethingWentWrong),
                  ),
                  TextButton(
                      onPressed: () {
                        logic.retryLogin();
                        Get.back();
                      },
                      child: Text(lo(context).retry)),
                ],
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/enter_otp.png',
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                logic.otpController.clear();
                                Get.offAndToNamed('/root');
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    logic.phoneNumber,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      fontFamily: 'Public Sans',
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                    size: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
                            child: Theme(
                                data: ThemeData(
                                  colorScheme: const ColorScheme.dark(
                                      primary: C.darkBlue),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: C.darkBlue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: C.darkBlue, width: 2.0),
                                    ),
                                  ),
                                ),
                                child: SMSCodeInputCustom(
                                  onSubmit: (otp) => logic.verifyOTP,
                                  textEditingController: logic.otpController,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
                            child: ElevatedButton(
                              onPressed: () {
                                final otp = logic.otpController.text;
                                if (otp.length != 6) {
                                  return;
                                }
                                logic.verifyOTP();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(lo(context).submit),
                              ),
                            ),
                          ),
                          if (logic.status.isLoading)
                            const LinearProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                ),
                // helpGroup(context),
              ],
            );
          },
        ),
        // bottomNavigationBar: ServerSwitcher(),
      ),
    );
  }
}

class SMSCodeInputCustom extends StatefulWidget {
  final bool autofocus;
  final Widget? text;
  final TextEditingController textEditingController;

  final SMSCodeSubmitCallback? onSubmit;

  const SMSCodeInputCustom({
    Key? key,
    this.autofocus = true,
    this.text,
    required this.textEditingController,
    this.onSubmit,
  }) : super(key: key);

  @override
  SMSCodeInputCustomState createState() => SMSCodeInputCustomState();
}

const NUMBER_SLOT_WIDTH = 44.0;
const NUMBER_SLOT_HEIGHT = 55.0;
const NUMBER_SLOT_MARGIN = 5.5;

class SMSCodeInputCustomState extends State<SMSCodeInputCustom> {
  var code = ''.obs;

  // late final controller = TextEditingController()..addListener(onChange);
  late TextEditingController controller;
  final focusNode = FocusNode();

  void onChange() {
    code.value = controller.text;
  }

  @override
  void initState() {
    super.initState();
    controller = widget.textEditingController;
    controller.addListener(onChange);
  }

  @override
  Widget build(BuildContext context) {
    final state = AuthState.maybeOf(context);

    Widget? text;
    if (state is CredentialReceived ||
        state is SigningIn ||
        state is SignedIn) {
      text = Text(lo(context).didNotReceiveOTP);
    }

    if (state is AuthFailed) {
      text = ErrorText(exception: state.exception);
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: NUMBER_SLOT_WIDTH * 6 + NUMBER_SLOT_MARGIN * 12,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(NUMBER_SLOT_MARGIN),
                child: Text(
                  lo(context).enterOTP,
                  style: TextStyle(color: C.darkBlue),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 6; i++)
                    Obx(() {
                      return _NumberSlot(
                          number: code.value.length > i ? code.value[i] : '');
                    }),
                ],
              ),
              if (widget.text != null || text != null)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: widget.text ?? text,
                ),
            ],
          ),
          Opacity(
            opacity: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextFormField(
                autofillHints: const [AutofillHints.oneTimeCode],
                autofocus: true,
                focusNode: focusNode,
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                onFieldSubmitted: (v) {
                  if (v == null) return;
                  if (v.length < 6) return;
                  widget.onSubmit?.call(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberSlot extends StatefulWidget {
  final String number;

  const _NumberSlot({Key? key, this.number = ''}) : super(key: key);

  @override
  _NumberSlotState createState() => _NumberSlotState();
}

class _NumberSlotState extends State<_NumberSlot>
    with SingleTickerProviderStateMixin {
  bool hasError = false;

  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  @override
  void didUpdateWidget(covariant _NumberSlot oldWidget) {
    if (oldWidget.number.isEmpty && widget.number.isNotEmpty) {
      controller.animateTo(1);
    }

    if (oldWidget.number.isNotEmpty && widget.number.isEmpty) {
      controller.animateBack(0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = Theme.of(context).inputDecorationTheme.border;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final errorColor = Theme.of(context).errorColor;

    final color = hasError ? errorColor : primaryColor;

    return Container(
      width: NUMBER_SLOT_WIDTH,
      height: NUMBER_SLOT_HEIGHT,
      decoration: _NumberSlotDecoration(
        inputBorder: inputBorder ?? const UnderlineInputBorder(),
        color: color,
      ),
      margin: const EdgeInsets.all(NUMBER_SLOT_MARGIN),
      child: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.value,
              child: child,
            );
          },
          child: Text(
            widget.number,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

typedef SMSCodeSubmitCallback = void Function(String smsCode);

class _NumberSlotDecoration extends Decoration {
  final InputBorder inputBorder;
  final Color color;

  _NumberSlotDecoration({
    required this.inputBorder,
    required this.color,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _NumberDecorationPainter(
      onChanged: onChanged,
      inputBorder: inputBorder,
      color: color,
    );
  }
}

class _NumberDecorationPainter extends BoxPainter {
  final InputBorder inputBorder;
  final Color color;

  _NumberDecorationPainter({
    VoidCallback? onChanged,
    required this.inputBorder,
    required this.color,
  }) : super(onChanged);

  final rect = const Rect.fromLTWH(0, 0, NUMBER_SLOT_WIDTH, NUMBER_SLOT_HEIGHT);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    inputBorder
        .copyWith(borderSide: BorderSide(color: color, width: 2))
        .paint(canvas, rect);
    canvas.restore();
  }
}
