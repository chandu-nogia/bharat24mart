// ignore_for_file: file_names

import 'package:project/all_imports.dart';

Widget buildTextField(context,
    {controllerData,
    color,
    colorBorder,
    validation,
    keyboardType,
    obscureText,
    hintText,
    suffixIcon,
    readOnly,
    maxLines,
    hintColor,
    prifix,
    prifixIcon,
    maxLength}) {
  return Padding(
    padding: EdgeInsets.only(top: 20.h),
    child: Container(
      // height: 50.h,
      decoration: BoxDecoration(
          // color: color ?? AppColorBody.blue,
          borderRadius: BorderRadius.circular(12.0.r),
          border: Border.all(color: colorBorder ?? Colors.transparent)),
      child: TextFormField(
        readOnly: readOnly ?? false,
        validator: validation,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        maxLines: maxLines ?? 1,
        maxLength: maxLength ?? 30,
        style: TextStyle(
            color: hintColor ?? AppColorText.white, fontFamily: "Roboto"),
        keyboardType: keyboardType ?? TextInputType.multiline,
        textInputAction: TextInputAction.next,
        controller: controllerData,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.w),
            counterText: "",
            prefix: prifix,
            prefixIcon: prifixIcon,
            suffixIcon: suffixIcon ?? const SizedBox(),
            hintStyle: TextStyle(
                color: hintColor ?? AppColorText.white, fontFamily: "Roboto"),
            hintText: hintText,
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12.0.r)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.yellow),
                borderRadius: BorderRadius.circular(12.0.r)),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(12.r)),
            fillColor: color ?? AppColorBody.blue,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.r))),
      ),
    ),
  );
}
