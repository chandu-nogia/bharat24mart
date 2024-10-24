// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

import '../../../all_imports.dart';
import '../../../commons/routerPages/dio_api.dart';
import '../../../commons/widgetsPages/flutter_secure_token.dart';
// import '../SingUpPage/singUpRepoPage.dart';
import '../otpVerification/otpVerficationScreenPage.dart';

class LoginGetController extends GetxController {
  @override
  void dispose() {
    phoneController.close();
    passwordController.close();
    super.dispose();
  }

  final show_password = false.obs;
  final loader = false.obs;
  final formkey = GlobalKey<FormState>();
  final phoneController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  loginController({required BuildContext context}) async {
    Map data = {
      "phone": phoneController.value.text.trim(),
      "password": passwordController.value.text.trim()
    };
    var response =
        await ApiMethod().putDioRequest(ApiUser.logInApi, data: data);
    // var response = await Authentication().loginApi(data: data);
    loader.value = true;
    if (response["success"] == true) {
      if (response["data"]["is_verified"] == 1) {
        String token = await response['data']['access_token'];

        await MyStorage()
            // ref.watch(storageProvider)
            .writeData(key: 'token', value: token);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Bottombar()),
            (route) => false);
        // .then((value) => ref.read(navigateProvider.notifier).state = 0);
        loader.value = false;
        // ref.invalidate(loadingProvider);
        messageField(msg: response["message"]);
      } else if (response["data"]["is_verified"] == 0) {
        buildPush(
            context: context,
            widget: OtpVerifySignIn(
                value: 1,
                number: phoneController.value.text.trim().toString()));
        loader.value = false;
        // ref.invalidate(loadingProvider);
      }
    } else if (response["success"] == false) {
      loader.value = false;
      // ref.invalidate(loadingProvider);
      return messageField(msg: response["message"]);
    } else {
      loader.value = false;
      // ref.invalidate(loadingProvider);
      return messageField(msg: response["msg"]);
    }
  }
}
