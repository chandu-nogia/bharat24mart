// ignore_for_file: file_names

import 'package:project/all_imports.dart';

Widget buildContainerB(
    {height,
    width,
    color,
    borderColor,
    value,
    text,
    colortext,
    fontWeight,
    fontSize,
    borderRadius,
    circularProgColor}) {
  return Container(
    height: height ?? 40.h,
    width: width ?? 1.sw,
    decoration: BoxDecoration(
        color: color ?? AppColorBody.blue,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.w),
        border: Border.all(color: borderColor ?? AppColorBody.blue)),
    child: Center(
        child: value
            ? CircularProgressIndicator(
                color: circularProgColor ?? AppColorBody.white)
            : Text(
                text,
                style: TextStyle(
                    color: colortext ?? AppColorText.white,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontSize: fontSize ?? 16.w,
                    fontFamily: "Roboto"),
              )),
  );
}
