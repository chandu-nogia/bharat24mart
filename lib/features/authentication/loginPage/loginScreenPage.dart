// ignore_for_file: must_be_immutable, unused_result, file_names

import 'package:get/get.dart';
import 'package:project/all_imports.dart';
import 'package:project/features/authentication/loginPage/getx_controller.dart';

// import '../SingUpPage/singUpControllerpage.dart';
// import 'loginControllerpage.dart';

// import 'loginRepoPage.dart';

String pattern = r'^[1-9]\d{9}$';
RegExp phoneregExp = RegExp(pattern);

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final RegExp phoneRegExp = RegExp(r'^\d{10}$');

  final controller = Get.put(LoginGetController());
  @override
  Widget build(BuildContext context) {
    // final loader = ref.watch(loadingProvider);
    // final isShow = ref.watch(showLoginPasswordProvider);
    // final loginControllerBuild = ref.watch(loginTextFieldProvider.notifier);
    // setState(() {
    //   ref.read(loginTextFieldProvider.notifier);
    // });
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                color: AppColorBody.blue,
                height: 106.h,
              ),
              Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        color: AppColorBody.blue,
                        image: const DecorationImage(
                            image: AssetImage("assets/image/login.png"),
                            fit: BoxFit.fill)),
                    child: Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Form(
                            key: controller.formkey,
                            child: Column(children: [
                              buildText(
                                  text: "  Welcome.",
                                  fontSize: 24.w,
                                  color: AppColorText.white,
                                  fontWeight: FontWeight.w500),
                              buildText(
                                  text: "     Gold to see you!.",
                                  fontSize: 24.w,
                                  color: AppColorText.white,
                                  fontWeight: FontWeight.w400),
                              SizedBox(
                                height: 183.h,
                              ),
                              buildTextField(validation: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your Numbers";
                                } else if (value.length < 10) {
                                  return "Please enter 10 digit Number";
                                } else {
                                  if (!phoneregExp.hasMatch(value)) {
                                    return "Please enter Valid Mobile Number";
                                  }
                                  return null;
                                }
                              },
                                  prifixIcon: SizedBox(
                                      child: Padding(
                                          padding: EdgeInsets.all(12.0.r),
                                          child: Text("+91",
                                              style: TextStyle(
                                                  color: AppColorText.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.h)))),
                                  context,
                                  maxLines: 1,
                                  maxLength: 10,
                                  controllerData:
                                      controller.phoneController.value,
                                  keyboardType: TextInputType.phone,
                                  hintText: "Enter Number"),
                              SizedBox(height: 5.h),
                              Obx(
                                () => buildTextField(context,
                                    validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password is required";
                                  }
                                  // Perform custom password validation here
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters long";
                                  }

                                  return null;
                                },
                                    controllerData:
                                        controller.passwordController.value,
                                    obscureText: controller.show_password.value,
                                    hintText: "Password",
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        controller.show_password.value =
                                            !controller.show_password.value;
                                      },
                                      child: Icon(
                                        controller.show_password.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColorBody.white,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                      onTap: () {
                                        buildPush(
                                            context: context,
                                            widget: const ForgotPassword());
                                      },
                                      child: buildText(
                                          text: "Forgot Password",
                                          fontSize: 14.w,
                                          color: AppColorText.black,
                                          fontWeight: FontWeight.w400))),
                              SizedBox(height: 20.h),
                              Obx(
                                () => InkWell(
                                    onTap: () {
                                      if (controller.formkey.currentState!
                                          .validate()) {
                                        // ref.read(loadingProvider.notifier).state =
                                        //     true;

                                        // ref
                                        //     .read(
                                        //         loginTextFieldProvider.notifier)
                                        controller.loginController(
                                            context: context);

                                        // ref
                                        //     .refresh(loginTextFieldProvider)
                                        //     .dispose();
                                      }
                                    },
                                    child: buildContainerB(
                                      fontSize: 18.w,
                                      color: AppColorBody.white,
                                      borderColor: AppColorBody.blue,
                                      value: controller.loader.value,
                                      text: "Login",
                                      colortext: AppColorText.blue,
                                      circularProgColor: AppColorText.blue,
                                    )),
                              ),
                              SizedBox(height: 20.h),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAnAccount(),
                                        ));
                                  },
                                  child: buildText(
                                      text: "Create Account",
                                      fontSize: 18.w,
                                      color: AppColorText.blue,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 20.h)
                            ]))))
              ])
            ])));
  }
}
