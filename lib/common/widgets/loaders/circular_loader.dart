import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

/// Widget tròn loader với màu nền và màu nền có thể tùy chỉnh.
class SHFCircularLoader extends StatelessWidget {
  /// Constructor mặc định cho SHFCircularLoader.
  ///
  /// Parameters:
  ///   - foregroundColor: Màu của tròn loader.
  ///   - backgroundColor: Màu nền của tròn loader.
  const SHFCircularLoader({
    super.key,
    this.foregroundColor = SHFColors.white,
    this.backgroundColor = SHFColors.primary,
  });

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SHFSizes.lg),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle), // Nền tròn
      child: Center(
        child: CircularProgressIndicator(color: foregroundColor, backgroundColor: Colors.transparent), // Loader tròn
      ),
    );
  }
}
