// ignore_for_file: file_names

import 'dart:async';

import 'package:project/all_imports.dart';
import 'package:project/main.dart';

messageField({required String msg, Color? snacColor}) {
  _debouncer.run(() {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      margin: EdgeInsets.only(bottom: 10.0.h, right: 20.w, left: 20.w),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Text(" $msg",
          style: TextStyle(
              color: AppColorText.white, fontFamily: "Roboto", fontSize: 15.w)),
      backgroundColor: snacColor ?? AppColorBody.blue,
    ));
    Future.delayed(const Duration(seconds: 3), () {
      scaffoldMessengerKey.currentState?.clearSnackBars();
      _debouncer._timer?.cancel();
    });
  });
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer(this.milliseconds);

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer!.cancel(); // Cancel any previous timer
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

final Debouncer _debouncer = Debouncer(500); //

