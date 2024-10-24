import 'package:project/all_imports.dart';

Widget buildText({text, fontSize, color, fontWeight, overflow}) {
  return Text(
    text ?? "",
    style: TextStyle(
        fontSize: fontSize,
        color: color ?? AppColorText.black,
        fontWeight: fontWeight,
        fontFamily: "Roboto"),
    overflow: overflow,
  );
}
