import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_banner_desktop.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return SHFSiteTemplate(
      desktop: EditBannerDesktopScreen(banner: banner),
    );
  }
}
