
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/product/product_controller.dart';

class ProductTableHeader extends StatelessWidget {
  const ProductTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Row(
      children: [
        Expanded(
          flex: !SHFDeviceUtils.isDesktopScreen(context) ? 1 : 3,
          child: Row(
            children: [
              SizedBox(
                width: 140,
                child: ElevatedButton(onPressed: () => Get.toNamed(SHFRoutes.createProduct), child: const Text('Thêm sản phẩm')),
              ),
            ],
          ),
        ),
        Expanded(
          flex: SHFDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Tìm kiếm', prefixIcon: Icon(Iconsax.search_normal)),
          ),
        ),
      ],
    );
  }
}
