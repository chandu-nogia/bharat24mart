// ignore_for_file: file_names

import 'package:project/all_imports.dart';

Widget buildTab({no, text, width, data}) {
  return Tab(
      child: Padding(
    padding: EdgeInsets.only(right: 5.w),
    child: Container(
        decoration: BoxDecoration(
            color: data == no ? AppColorText.blue : AppColorText.blueLit,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: AppColorText.white)),
        width: 150.w,
        height: 32.h,
        child: Center(
            child: Text(text.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: data == no
                        ? AppColorText.white
                        : AppColorText.black)))),
  ));
}
