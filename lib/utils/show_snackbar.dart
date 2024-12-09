import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/colors.dart';

void showSnackBar(
    {required BuildContext context,
    required String content,
    bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      content: Text(
        content,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
      ),
      margin: const EdgeInsets.all(20),
      backgroundColor: isError ? Colors.red.shade600 : primaryColor,
    ),
  );
}
