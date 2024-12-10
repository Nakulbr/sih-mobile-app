import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/colors.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';
import 'package:sih_hackathon/widgets/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.isRounded = false,
    required this.onPressed,
    required this.content,
    required this.width,
  });

  final VoidCallback? onPressed;
  final String content;
  final double width;
  final bool isRounded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRounded ? 32 : 10),
          ),
        ),
        child: CustomText(
          content: content,
          fontWeight: CustomFontWeight.normal,
          fontSize: 16,
          fontColor: Colors.white,
        ),
      ),
    );
  }
}
