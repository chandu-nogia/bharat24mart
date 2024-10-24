// ignore_for_file: must_be_immutable, unused_result, file_names, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:project/all_imports.dart';
import 'package:project/features/authentication/SingUpPage/singUpControllerpage.dart';

class CreateAnAccount extends StatelessWidget {
  CreateAnAccount({super.key});

  final _formkey = GlobalKey<FormState>();
  final controller = Get.put(Singupcontrollerpage());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 46.h),
                            buildText(
                                text: "Create Account",
                                fontSize: 22.w,
                                color: AppColorText.blue,
                                fontWeight: FontWeight.w500),
                            SizedBox(height: 20.h),
                            buildTextField(context, validation: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Name";
                              } else {
                                return null;
                              }
                            },
                                controllerData: controller.nameController.value,
                                hintText: "Enter Name"),
                            buildTextField(context, validation: (value) {
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
                                maxLength: 10,
                                controllerData:
                                    controller.numberController.value,
                                keyboardType: TextInputType.phone,
                                hintText: "Enter Number"),

                            SizedBox(
                              height: 20.h,
                            ),
                            DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(8),
                              // menuMaxHeight: 10,
                              // isDense: true,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(13),
                                  isDense: true,
                                  // contentPadding: EdgeInsets.only(right: 0),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColorBody.blue),
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  filled: true,
                                  focusColor: AppColorBody.blue,
                                  enabled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColorBody.blue),
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColorBody.blue),
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColorBody.blue),
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColorBody.blue),
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  fillColor: AppColorBody.blue),
                              autofocus: true,
                              // iconEnabledColor: Colors.white,
                              focusColor: AppColorBody.blue,
                              dropdownColor: AppColorBody.blue,
                              isExpanded: true,
                              value: controller.defaultValue.value,
                              items: [
                                const DropdownMenuItem(
                                  value: "",
                                  child: Text(
                                    "Select Gender",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ...controller.genderList
                                    .map<DropdownMenuItem<String>>((datas) {
                                  return DropdownMenuItem(
                                    value: datas['value'],
                                    child: Text(
                                      datas['title'].toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }),
                              ],
                              onChanged: (salutation) =>
                                  controller.defaultValue.value = salutation!,
                              // ref
                              // .read(defaultValueprovider.notifier)
                              // .state = salutation!,
                              validator: (value) {
                                if (value == null) {
                                  return 'field required';
                                } else if (value == "") {
                                  return "Please select gender";
                                }
                                return null;
                              },
                            ),
                            //  values==true? if (textEditorBuild.defaultValue == "")
                            //     Text(
                            //       "   Please select gender",
                            //       style: TextStyle(color: Colors.redAccent),
                            //     ):SizedBox(,)
                            buildTextField(context, validation: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Types of Customers";
                              } else {
                                return null;
                              }
                            },
                                controllerData:
                                    controller.customersController.value,
                                hintText: "Type of Customers"),
                            buildTextField(context, validation: (value) {
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
                                obscureText: controller.show_pw1.value,
                                hintText: "Password",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      controller.show_pw1.value =
                                          !controller.show_pw1.value;
                                      // ref
                                      //     .read(showSignupPassword1Provider
                                      //         .notifier)
                                      //     .state = isPassword ? false : true;
                                    },
                                    child: Icon(
                                        controller.show_pw1.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColorBody.white))),
                            buildTextField(context, validation: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Password";
                              } else if (controller
                                      .passwordController.value.text
                                      .trim() !=
                                  controller
                                      .confirmPasswordController.value.text
                                      .trim()) {
                                return " Password and Confirm Password not Match";
                              } else {
                                return null;
                              }
                            },
                                controllerData:
                                    controller.confirmPasswordController.value,
                                obscureText: controller.show_pw2.value,
                                hintText: "Confirm Password",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      controller.show_pw2.value =
                                          !controller.show_pw2.value;
                                      // ref
                                      //     .read(showSignupPassword2Provider
                                      //         .notifier)
                                      //     .state = isConPassword ? false : true;
                                    },
                                    child: Icon(
                                        controller.show_pw2.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColorBody.white))),
                            SizedBox(height: 30.h),
                            InkWell(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    // ref
                                    //     .read(lodeingSignupprovider.notifier)
                                    //     .state = true;

                                    // ref
                                    //     .read(textControllerProvider.notifier)
                                    controller.signUpController(
                                        context: context);
                                  }
                                },
                                child: buildContainerB(
                                    fontSize: 18.w,
                                    color: AppColorBody.white,
                                    borderColor: AppColorBody.blue,
                                    text: "SignUp",
                                    value: controller.loader.value,
                                    colortext: AppColorText.blue,
                                    circularProgColor: AppColorText.blue)),
                            SizedBox(height: 30.h),
                            Center(
                              child: buildRichText(
                                  color: AppColorText.grey,
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w400,
                                  widget: [
                                    const TextSpan(
                                      text: "Already have an account? ",
                                    ),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pop(context);
                                          },
                                        text: "Login",
                                        style: TextStyle(
                                            color: AppColorText.blue)),
                                  ]),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 2.h,
                                      width: 50.w,
                                      color: AppColorBody.grey),
                                  SizedBox(width: 14.w),
                                  buildText(
                                      text: "Or",
                                      color: AppColorText.black,
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(width: 14.w),
                                  Container(
                                      height: 2.h,
                                      width: 50.w,
                                      color: AppColorBody.grey)
                                ]),
                            SizedBox(height: 15.h),
                            Center(
                                child: buildText(
                                    text: "Login With",
                                    color: AppColorText.blue,
                                    fontSize: 14.w,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 30.h),
                            buildContainer(
                                height: 50.h,
                                width: 1.sw,
                                color: AppColorBody.white,
                                borderColor: AppColorBody.blue,
                                borderRadius: 12.w,
                                widget: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                          height: 20.h,
                                          width: 20.w,
                                          image: const AssetImage(
                                              "assets/image/google.png")),
                                      SizedBox(width: 10.w),
                                      buildText(
                                          text: "Continue With Google",
                                          color: AppColorText.blue,
                                          fontSize: 18.w,
                                          fontWeight: FontWeight.w500),
                                    ])),
                            SizedBox(height: 30.h),
                          ]))))),
    );
  }
}
