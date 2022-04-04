library internet_availability;

import 'dart:io';

/// A Calculator.
class InternetAvailability {
  /// Returns [value] plus 1.
  static void checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
