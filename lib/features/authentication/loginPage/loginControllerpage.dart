// // ignore_for_file: file_names, use_build_context_synchronously, avoid_print

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../commons/routerPages/apiPage.dart';
// import '../../../commons/routerPages/dio_api.dart';
// import '../../../commons/routerPages/navigationPage.dart';
// import '../../../commons/widgetsPages/bottomBarPage.dart';
// import '../../../commons/widgetsPages/flutter_secure_token.dart';
// import '../../../commons/widgetsPages/snackBarPage.dart';
// import '../SingUpPage/singUpRepoPage.dart';
// import '../otpVerification/otpVerficationScreenPage.dart';

// // final showLoginPasswordProvider =
// //     StateProvider.autoDispose<bool>((ref) => true);
// // final loadingProvider = StateProvider.autoDispose<bool>((ref) => false);

// final loginTextFieldProvider = StateNotifierProvider.autoDispose((ref) {
//   final respo = ref.watch(authApiProvider);
//   return LoginControllerNotifier(res: respo, ref: ref);
// });

// class LoginControllerNotifier extends StateNotifier {
//   final Authentication res;
//   final Ref ref;

//   LoginControllerNotifier({required this.res, required this.ref}) : super('');
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   loginclears() {
//     phoneController.clear();
//     passwordController.clear();
//   }

//   loginController({required BuildContext context}) async {
//     ref.onDispose(() {
//       loginclears();
//     });
//     Map data = {
//       "phone": phoneController.text.trim(),
//       "password": passwordController.text.trim()
//     };

//     var response = await res.loginApi(data: data);


//     if (response["success"] == true) {
//       if (response["data"]["is_verified"] == 1) {
//         String token = await response['data']['access_token'];

//         await ref.watch(storageProvider).writeData(key: 'token', value: token);

//         Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => Bottombar()),
//                 (route) => false)
//             .then((value) => ref.read(navigateProvider.notifier).state = 0);

//         // ref.invalidate(loadingProvider);
//         messageField(msg: response["message"]);
//       } else if (response["data"]["is_verified"] == 0) {
//         buildPush(
//             context: context,
//             widget: OtpVerifySignIn(
//                 value: 1, number: phoneController.text.trim().toString()));

//         // ref.invalidate(loadingProvider);
//       }
//     } else if (response["success"] == false) {
//       // ref.invalidate(loadingProvider);
//       return messageField(msg: response["message"]);
//     } else {
//       // ref.invalidate(loadingProvider);
//       return messageField(msg: response["msg"]);
//     }
//   }
// }
