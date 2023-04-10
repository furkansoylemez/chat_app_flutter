import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonLottie extends StatelessWidget {
  CommonLottie(
    this.lottiePath, {
    super.key,
    this.fit,
  });
  final String lottiePath;
  BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      lottiePath,
      frameRate: FrameRate.max,
      repeat: true,
      animate: true,
      fit: fit,
    );
  }
}
