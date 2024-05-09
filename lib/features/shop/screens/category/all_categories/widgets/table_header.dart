import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/category/category_controller.dart';

class CategoryTableHeader extends StatelessWidget {
  const CategoryTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Row(
      children: [
        Expanded(
          flex: !SHFDeviceUtils.isDesktopScreen(context) ? 1 : 3,
          child: Row(
            children: [
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () => Get.toNamed(SHFRoutes.createCategory),
                      child: const Text('Tạo Danh mục mới'))),
            ],
          ),
        ),
        Expanded(
          flex: SHFDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(
                hintText: 'Tìm kiếm danh mục',
                prefixIcon: Icon(Iconsax.search_normal)),
          ),
        ),
      ],
    );
  }
}
