import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/categories_desktop.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SHFSiteTemplate(desktop: CustomersDesktopScreen(), );
  }
}