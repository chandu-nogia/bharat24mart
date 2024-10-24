// ignore_for_file: must_be_immutable, use_build_context_synchronously, file_names

import 'package:project/all_imports.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'otpVerficationControllerpage.dart';

class OtpVerifySignIn extends ConsumerStatefulWidget {
  int value;
  dynamic number;
  OtpVerifySignIn({super.key, required this.number, required this.value});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OtpVerifySignInState();
}

TextEditingController otpcontroller = TextEditingController();

class _OtpVerifySignInState extends ConsumerState<OtpVerifySignIn> {
  @override
  void dispose() {
    otpcontroller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(loaderOtpProvider);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            width: 1.sw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  stops: [0.1, 0.9],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
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
                      SizedBox(
                        height: 40.h,
                      ),
                      buildText(
                          color: AppColorText.white,
                          fontSize: 24.w,
                          text: "OTP Verification",
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildText(
                          color: AppColorText.white,
                          fontSize: 16.w,
                          text:
                              "Enter the verification code we just sent on your email address.",
                          fontWeight: FontWeight.w400),
                      SizedBox(height: 40.h),
                      SizedBox(
                        height: 55.h,
                        child: PinCodeTextField(
                          enablePinAutofill: true,
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                              activeColor: Colors.white,
                              selectedColor: Colors.white,
                              disabledColor: Colors.white,
                              errorBorderColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: AppColorBody.blue,
                              inactiveColor: Colors.white,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          // errorAnimationController: errorController,
                          controller: otpcontroller,
                          onCompleted: (v) {
                            ref.read(otpProvider.notifier).otpSendprovider(
                                value: widget.value,
                                context: context,
                                number: widget.number,
                                otpCode: otpcontroller.text.trim());
                          },
                          onChanged: (value) {},
                          beforeTextPaste: (text) {
                            return true;
                          },
                          appContext: context,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      InkWell(
                          onTap: () {
                            ref.read(otpProvider.notifier).otpSendprovider(
                                value: widget.value,
                                context: context,
                                number: widget.number,
                                otpCode: otpcontroller.text.trim());
                          },
                          child: SizedBox(
                            height: 55.h,
                            child: buildContainerB(
                                fontSize: 18.w,
                                color: AppColorBody.white,
                                borderColor: AppColorBody.white,
                                value: loader,
                                text: "Verify",
                                colortext: AppColorText.black,
                                circularProgColor: AppColorText.blue),
                          ))
                    ]))));
  }
}
