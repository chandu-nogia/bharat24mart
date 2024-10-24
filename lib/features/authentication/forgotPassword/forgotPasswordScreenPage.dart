// ignore_for_file: use_build_context_synchronously, file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:project/all_imports.dart';

import 'package:http/http.dart' as http;

import '../otpVerification/otpVerficationScreenPage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
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
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      BackButton(
                        color: AppColorBody.white,
                        style: ButtonStyle(
                            iconSize: MaterialStateProperty.all(30.w)),
                      ),
                      SizedBox(height: 40.h),
                      buildText(
                          color: AppColorText.white,
                          fontSize: 24.w,
                          text: "Forgot Password?",
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildText(
                          color: AppColorText.white,
                          fontSize: 16.w,
                          text:
                              "Don't worry! It occurs. Please enter the email address linked with your account.",
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        height: 40.h,
                      ),
                      buildText(
                          color: AppColorText.white,
                          fontSize: 18.w,
                          text: "Enter Mobile Number",
                          fontWeight: FontWeight.w600),
                      buildTextField(context,
                          prifixIcon: SizedBox(
                              child: Padding(
                                  padding: EdgeInsets.all(17.0.r),
                                  child: Text("+91",
                                      style: TextStyle(
                                          color: AppColorText.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.h)))),
                          maxLength: 10,
                          maxLines: 1,
                          controllerData: phoneController, validation: (value) {
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
                          color: AppColorBody.white,
                          hintText: "Your Number",
                          keyboardType: TextInputType.phone,
                          hintColor: AppColorBody.black),
                      SizedBox(
                        height: 40.h,
                      ),
                      InkWell(
                          onTap: () async {
                            if (phoneController.text.trim().isEmpty) {
                              messageField(msg: "Enter Phone Number ");
                            } else {
                              var apiData = await forgot_Password();
                              if (apiData['status'] == 1) {
                                buildPush(
                                    context: context,
                                    widget: OtpVerifySignIn(
                                      value: 0,
                                      number: phoneController.text.trim(),
                                    ));
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
                              text: "Send Code",
                              colortext: AppColorText.black,
                              circularProgColor: AppColorText.blue))
                    ]))));
  }

  TextEditingController phoneController = TextEditingController();
  bool loader = false;

  Future forgot_Password() async {
    setState(() {
      loader = true;
    });
    var appUrl = Uri.parse(ApiUser.forgotPassword);
    http.Response response =
        await http.post(appUrl, body: {"phone": phoneController.text});
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
