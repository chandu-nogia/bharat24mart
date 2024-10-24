// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/main.dart';

import '../../../commons/routerPages/apiPage.dart';
import '../../../commons/routerPages/dio_api.dart';
import '../../../commons/widgetsPages/snackBarPage.dart';

final showchangePassword1Provider = StateProvider<bool>((ref) => true);
final showchangePassword2Provider = StateProvider<bool>((ref) => true);
final lodeingchangeprovider = StateProvider<bool>((ref) => false);

final changepasswordProvider = Provider<TextControllerNotifier>((ref) {
  // final respo = ref.watch(authApiProvider);
  return TextControllerNotifier(ref: ref);
});

class TextControllerNotifier {
  // final Authentication resp;
  final Ref ref;

  TextControllerNotifier({required this.ref});

  TextEditingController oldpassword = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
}

final updateApiProvider = Provider<UpdateRepo>((ref) {
  final reso = ref.watch(changepasswordProvider);
  return UpdateRepo(ref: ref, reso: reso);
});

class UpdateRepo {
  final Ref ref;
  final TextControllerNotifier reso;

  UpdateRepo({required this.ref, required this.reso});

  updatePassword() async {
    Map data = {
      "password": reso.oldpassword.text.trim(),
      "new_password": reso.passwordController.text.trim(),
      "confirm_new_password": reso.confirmPasswordController.text.trim()
    };

    var response =
        await ApiMethod().putDioRequest(ApiUser.updatePassword, data: data);

    ref.read(lodeingchangeprovider.notifier).state = false;
    if (response['success'] == true) {
      messageField(msg: response['message']);
      navigatorKey.currentState!.pop();
      // Navigator.pop(context);
      return response;
    } else if (response['success'] == false) {
      ref.read(lodeingchangeprovider.notifier).state = false;
      messageField(msg: response['message']);
      return "Error: Some technical issue";
    }
  }
}
