import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';
import 'package:sih_hackathon/widgets/custom_text.dart';

class ContinueWithButton extends StatelessWidget {
  const ContinueWithButton({
    super.key,
    required this.platform,
    required this.platformIcon,
    required this.onPressed,
  });

  final String platform;
  final String platformIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              platformIcon,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 5),
            CustomText(
              content: "Continue with $platform",
              fontWeight: CustomFontWeight.semibold,
              fontSize: 16,
            )
          ],
        ),
      ),
    );
  }
}
