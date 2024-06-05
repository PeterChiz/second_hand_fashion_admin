import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/order_detail_desktop.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    return SHFSiteTemplate(
      desktop: OrderDetailDesktopScreen(order: order),
    );
  }
}
