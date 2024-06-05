import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_brand_desktop.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return SHFSiteTemplate(
      desktop: EditBrandDesktopScreen(brand: brand),
    );
  }
}
