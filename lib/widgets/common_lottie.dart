import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonLottie extends StatelessWidget {
  const CommonLottie(
    this.lottiePath, {
    super.key,
  });
  final String lottiePath;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      lottiePath,
      frameRate: FrameRate.max,
      repeat: true,
      animate: true,
    );
  }
}
