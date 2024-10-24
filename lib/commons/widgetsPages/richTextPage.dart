// ignore_for_file: file_names

import 'package:project/all_imports.dart';

Widget buildRichText(
    {fontSize,
      fontWeight,
      color,
      widget
      }) {
  return Text.rich(TextSpan(
    style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: "Roboto"),
      children:
    widget
  ));
}