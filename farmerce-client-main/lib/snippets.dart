import 'package:flutter/material.dart';

import 'locator.dart';

void showSnackbar(String? msg, {Color? color, Duration? duration}) {
  getIt<GlobalKey<ScaffoldMessengerState>>().currentState?.showSnackBar(
        SnackBar(
          backgroundColor: color ?? Colors.red,
          content: Text(
            "$msg",
          ),
          duration: duration ?? const Duration(milliseconds: 8000),
        ),
      );
}
