// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/SingUpPage/singUpRepoPage.dart';
// import 'package:project/features/authentication/createNewPassword/createNewPaControllerpage.dart';

import '../../../commons/routerPages/navigationPage.dart';
import '../../../commons/widgetsPages/snackBarPage.dart';
import '../otpVerification/otpVerficationScreenPage.dart';

// final showSignupPassword1Provider =
//     StateProvider.autoDispose<bool>((ref) => true);
// final showSignupPassword2Provider =
//     StateProvider.autoDispose<bool>((ref) => true);
// final lodeingSignupprovider = StateProvider<bool>((ref) => false);

// final defaultValueprovider = StateProvider<String>((ref) => '');
// final dropDownListDataprovider = StateProvider<List>((ref) => [
//       {"title": "Male", "value": "1"},
//       {"title": "Female", "value": "2"},
//       {"title": "Trans", "value": "0"}
//     ]);

// final textControllerProvider = StateNotifierProvider.autoDispose((ref) {
//   // final respo = ref.watch(authApiProvider);
//   return TextControllerNotifier(ref: ref);
// });

class Singupcontrollerpage extends GetxController {
  // final Authentication resp;
  // final Ref ref;
  // TextControllerNotifier({required this.ref}) : super('');
  final nameController = TextEditingController().obs;
  final numberController = TextEditingController().obs;
  final genderController = TextEditingController().obs;
  final customersController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  final loader = false.obs;
  final show_pw1 = false.obs;
  final show_pw2 = false.obs;
  String selectedValue = 'Male';
  String selected = '1';
  RxString defaultValue = ''.obs;
  List<Map<String, String>> genderList = [
    {"title": "Male", "value": "1"},
    {"title": "Female", "value": "2"},
    {"title": "Trans", "value": "0"}
  ];



  signUpClear() {
    nameController.value.clear();
    numberController.value.clear();
    genderController.value.clear();
    customersController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
  }

  signUpController({required BuildContext context}) async {
    // ref.onDispose(() {
    signUpClear();
    // });
    Map data = {
      "name": nameController.value.text.trim(),
      "phone": numberController.value.text.trim(),
      "gender": defaultValue.value,
      "customers": customersController.value.text.trim(),
      "password": passwordController.value.text.trim(),
      "conpassword": confirmPasswordController.value.text.trim()
    };

    var response = await Authentication().createAccount(data: data);
    loader.value = true;
    if (response["status"] == 200) {
      buildPush(
          context: context,
          widget: OtpVerifySignIn(
            number: numberController.value.text.trim(),
            value: 1,
          ));
      loader.value = false;
      signUpClear();

      // ref.read(lodeingSignupprovider.notifier).state = false;

      messageField(msg: response["message"]);
    } else if (response["status"] == false) {
      loader.value = false;
      messageField(msg: response["msg"]);

      // ref.read(lodeingSignupprovider.notifier).state = false;
    }
  }
}
