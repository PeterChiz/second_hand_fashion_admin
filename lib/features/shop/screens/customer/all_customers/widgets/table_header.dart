import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/customer/customer_controller.dart';

class CustomerTableHeader extends StatelessWidget {
  const CustomerTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Row(
      children: [
        Expanded(flex: !SHFDeviceUtils.isDesktopScreen(context) ? 0 : 3, child: const SizedBox()),
        Expanded(
          flex: SHFDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Tìm kiếm khách hàng', prefixIcon: Icon(Iconsax.search_normal)),
          ),
        ),
      ],
    );
  }
}
