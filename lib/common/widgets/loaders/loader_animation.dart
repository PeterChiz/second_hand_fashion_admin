import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/image_strings.dart';

/// Widget tròn loader với màu nền và màu nền có thể tùy chỉnh.
class SHFLoaderAnimation extends StatelessWidget {
  const SHFLoaderAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(SHFImages.defaultLoaderAnimation,
            height: 200, width: 200));
  }
}
