import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/orders_desktop.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SHFSiteTemplate(desktop: OrdersDesktopScreen(), );
  }
}