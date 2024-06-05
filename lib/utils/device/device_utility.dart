import 'package:flutter/material.dart';

import '../constants/sizes.dart';

class SHFDeviceUtils {
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static bool isDesktopScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= SHFSizes.desktopScreenSize;
  }
}
