import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/brand/brand_controller.dart';

class BrandTableHeader extends StatelessWidget {
  const BrandTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Row(
      children: [
        Expanded(
          flex: !SHFDeviceUtils.isDesktopScreen(context) ? 1 : 3,
          child: Row(
            children: [
              SizedBox(width: 200, child: ElevatedButton(onPressed: () => Get.toNamed(SHFRoutes.createBrand), child: const Text('Tạo thương hiệu mới'))),
            ],
          ),
        ),
        Expanded(
          flex: SHFDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Tìm kiếm thương hiệu', prefixIcon: Icon(Iconsax.search_normal)),
          ),
        ),
      ],
    );
  }
}
