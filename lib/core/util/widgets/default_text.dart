import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  DefaultText({
    Key? key,
    required this.fontWeight,
    required this.color,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  double fontSize;
  Color color;
  String text;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
