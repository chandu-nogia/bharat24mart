import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/features/userProfile/Change_Password/change_password_provider.dart';
import '../../../commons/widgetsPages/ColorPage.dart';
import '../../../commons/widgetsPages/buttonPage.dart';
import '../../../commons/widgetsPages/textpage.dart';
import '../profile_edit_Controller.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textEditorBuild = ref.watch(changepasswordProvider);
    //  final textEditorBuild = ref.watch(textControllerProvider);
    final loader = ref.watch(lodeingchangeprovider);
    final isPassword = ref.watch(showchangePassword1Provider);
    final isConPassword = ref.watch(showchangePassword2Provider);
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 100.h,
            title: buildText(
                color: AppColorText.black,
                text: "Change Password",
                fontWeight: FontWeight.w500,
                fontSize: 25.w),
            centerTitle: true),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.h),
                          customTextField(context, padding: 0.h,
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
                              controllerData: textEditorBuild.oldpassword,
                              color: AppColorBody.white,
                              colorBorder: AppColorBody.grey,
                              hintText: "Old Password",
                              hintColor: AppColorBody.grey),
                          customTextField(context, padding: 0.h,
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
                                  textEditorBuild.passwordController,
                              obscureText: isPassword,
                              colorBorder: AppColorBody.grey,
                              color: AppColorBody.white,
                              // hintText: "email",
                              hintColor: AppColorBody.grey,
                              hintText: "New Password",
                              suffixIcon: InkWell(
                                  onTap: () {
                                    ref
                                        .read(showchangePassword1Provider
                                            .notifier)
                                        .state = isPassword ? false : true;
                                  },
                                  child: Icon(
                                    isPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColorBody.black,
                                    size: 24.w,
                                  ))),
                          customTextField(context,
                              padding: 0.h,
                              colorBorder: AppColorBody.grey,
                              color: AppColorBody.white,
                              // hintText: "email",
                              hintColor: AppColorBody.grey,
                              validation: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Confirm Password";
                            } else if (textEditorBuild
                                .passwordController.text.isEmpty) {
                              return "Please enter New Password";
                            } else if (textEditorBuild.passwordController.text
                                    .trim() !=
                                textEditorBuild.confirmPasswordController.text
                                    .trim()) {
                              return " Password and Confirm Password not Match";
                            } else {
                              return null;
                            }
                          },
                              controllerData:
                                  textEditorBuild.confirmPasswordController,
                              obscureText: isConPassword,
                              hintText: "Confirm Password",
                              suffixIcon: InkWell(
                                  onTap: () {
                                    ref
                                        .read(showchangePassword2Provider
                                            .notifier)
                                        .state = isConPassword ? false : true;
                                  },
                                  child: Icon(
                                      isConPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColorBody.black,
                                      size: 24.w))),
                          SizedBox(height: 30.h),
                          InkWell(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  ref
                                      .read(lodeingchangeprovider.notifier)
                                      .state = true;

                                  ref.read(updateApiProvider).updatePassword();
                                }
                              },
                              child: buildContainerB(
                                  fontSize: 18.w,
                                  color: AppColorBody.blue,
                                  borderColor: AppColorBody.blue,
                                  text: "Submit",
                                  value: loader,
                                  colortext: AppColorText.white,
                                  circularProgColor: AppColorText.white)),
                          SizedBox(height: 30.h),
                        ])))));
  }
}
