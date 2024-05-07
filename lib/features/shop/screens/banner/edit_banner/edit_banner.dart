import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_admin/features/shop/screens/banner/edit_banner/responsive_screens/edit_brand_tablet.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_banner_desktop.dart';
import 'responsive_screens/edit_banner_mobile.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return SHFSiteTemplate(
      desktop: EditBannerDesktopScreen(banner: banner),
      tablet: EditBannerTabletScreen(banner: banner),
      mobile: EditBannerMobileScreen(banner: banner),
    );
  }
}
