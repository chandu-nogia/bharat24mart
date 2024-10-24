// ignore_for_file: must_be_immutable, use_build_context_synchronously, file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/all_imports.dart';

class CreateNewPassword extends StatefulWidget {
  String? noPhone;
  // String? otpPin;

  CreateNewPassword({this.noPhone, super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              stops: [0.1, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF51C3E1),
                Color(0xFF8FADFE),
              ]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  BackButton(
                    color: AppColorBody.white,
                    style:
                        ButtonStyle(iconSize: MaterialStateProperty.all(30.w)),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  buildText(
                      color: AppColorText.white,
                      fontSize: 24.w,
                      text: "Create new password",
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 20.h,
                  ),
                  buildText(
                      color: AppColorText.white,
                      fontSize: 16.w,
                      text:
                          "Your new password must be unique form those previously used.",
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 40.h,
                  ),
                  buildText(
                      color: AppColorText.white,
                      fontSize: 18.w,
                      text: "New Password",
                      fontWeight: FontWeight.w600),
                  buildTextField(context, controllerData: newPasswordController,
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
                      color: AppColorBody.white,
                      hintText: "new password",
                      hintColor: AppColorBody.black,
                      obscureText: isShow,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                        child: Icon(
                          isShow ? Icons.visibility : Icons.visibility_off,
                          color: AppColorBody.grey,
                        ),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  buildText(
                      color: AppColorText.white,
                      fontSize: 18.w,
                      text: "Confirm Password",
                      fontWeight: FontWeight.w600),
                  buildTextField(context,
                      controllerData: confPasswordController,
                      validation: (value) {
                    if (value.isEmpty) {
                      return "Please enter Password";
                    } else if (newPasswordController.text.trim() !=
                        confPasswordController.text.trim()) {
                      return "New Password and Confirm Password not Match";
                    } else {
                      return null;
                    }
                  },
                      color: AppColorBody.white,
                      hintText: "confirm password",
                      hintColor: AppColorBody.black,
                      obscureText: isShowCp,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isShowCp = !isShowCp;
                          });
                        },
                        child: Icon(
                          isShowCp ? Icons.visibility : Icons.visibility_off,
                          color: AppColorBody.grey,
                        ),
                      )),
                  SizedBox(
                    height: 40.h,
                  ),
                  InkWell(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        var apiData = await resetPassword();

                        if (apiData["status"] == true) {
                          navigatorRemove(
                              context: context, widget: LoginPage());
                          messageField(msg: apiData["msg"]);
                        } else if (apiData["status"] == false) {
                          messageField(msg: apiData["msg"]);
                        } else {
                          messageField(msg: apiData["msg"]);
                        }
                      }
                    },
                    child: buildContainerB(
                      height: 55.h,
                      fontSize: 18.w,
                      color: AppColorBody.white,
                      borderColor: AppColorBody.white,
                      value: loader,
                      text: "Reset password",
                      colortext: AppColorText.black,
                      circularProgColor: AppColorText.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  bool loader = false;
  bool isShow = true;
  bool isShowCp = true;

  Future resetPassword() async {
    setState(() {
      loader = true;
    });
    var appUrl = Uri.parse(ApiUser.passwordUpdate);
    http.Response response = await http.post(appUrl, body: {
      "phone": widget.noPhone,
      "password": newPasswordController.text.trim(),
      "confirm_password": confPasswordController.text.trim()
    });
    if (response.statusCode == 200) {
      setState(() {
        loader = false;
      });
      var data = jsonDecode(response.body);
      return data;
    } else {
      setState(() {
        loader = false;
      });
    }
  }
}
