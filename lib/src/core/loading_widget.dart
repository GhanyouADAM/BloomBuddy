import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.height = 50});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/animations/Animated plant loader..json",
      height: height,
    );
  }
}
