import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/spacing_styles.dart';

/// Mẫu cho bố cục trang đăng nhập
class SHFLoginTemplate extends StatelessWidget {
  const SHFLoginTemplate({
    super.key,
    required this.child,
  });

  /// Widget sẽ được hiển thị bên trong mẫu đăng nhập
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: SHFSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SHFSizes.cardRadiusLg),
              color: SHFHelperFunctions.isDarkMode(context)
                  ? SHFColors.black
                  : Colors.white,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
