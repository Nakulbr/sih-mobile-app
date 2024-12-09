import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.content,
    required this.fontWeight,
    required this.fontSize,
    this.fontColor = Colors.black,
  });

  final String content;
  final FontWeight fontWeight;
  final double fontSize;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: fontColor,
      ),
    );
  }
}
