import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sih_hackathon/constants/colors.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCube(
      color: primaryColor,
      size: size,
    );
  }
}
