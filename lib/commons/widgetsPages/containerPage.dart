// ignore_for_file: file_names

import 'package:project/all_imports.dart';

Widget buildContainer(
    {height, width, color, borderColor, borderRadius, widget}) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius??8.w),
          border: Border.all(color: borderColor)),
      child: widget);
}



Widget buildBuildContainer({data, no, itemText}) {
  return buildContainer(
      borderRadius: 8.w,
      borderColor: AppColorBody.grey,
      color: AppColorBody.white,
      height: 40.h,
      width: 150.w,
      widget: Padding(
        padding:  EdgeInsets.all(8.w),
        child: Row(
          children: [
            buildContainer(
                borderRadius: 2.h,
                borderColor:
                data == no ? AppColorBody.blue : AppColorBody.grey,
                color: data == no ? AppColorBody.blue : AppColorBody.white,
                height: 20.h,
                width: 20.w,
                widget: Center(
                    child: data == no
                        ? Icon(
                      Icons.check,
                      color: AppColorBody.white,
                      size: 14.w,
                    )
                        :const SizedBox())),
            SizedBox(
              width: 10.w,
            ),
            buildText(
                text: itemText,
                color: AppColorText.black,
                fontWeight: FontWeight.w400,
                fontSize: 14.w),
          ],
        ),
      ));
}