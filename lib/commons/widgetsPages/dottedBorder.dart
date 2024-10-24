// ignore_for_file: file_names

import 'package:project/all_imports.dart';

Widget buildOrderLine({height, color}) {
  return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: DottedBorder(
          borderType: BorderType.RRect,
          color: color ?? AppColorBody.blue,
          dashPattern: [1.w, 3.w],
          borderPadding: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(0),
          strokeWidth: 2.w,
          child: SizedBox(height: height, width: 1.w)));
}

Widget buildOrder({text1, text2, color}) {
  return Row(children: [
    DottedBorder(
        borderType: BorderType.Circle,
        color: color ?? AppColorBody.blue,
        dashPattern: [14.w, 6.w],
        strokeWidth: 2.w,
        child: SizedBox(
            height: 40.h,
            width: 40.w,
            child: color == AppColorBody.blue || color == null
                ? Icon(
                    Icons.check_outlined,
                    color: AppColorBody.blue,
                  )
                : const SizedBox())),
    SizedBox(width: 16.w),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildText(
          color: AppColorText.black,
          text: text1,
          fontWeight: FontWeight.w500,
          fontSize: 14.w),
      buildText(
          color: AppColorText.grey,
          text: text2,
          fontWeight: FontWeight.w500,
          fontSize: 12.w)
    ])
  ]);
}
