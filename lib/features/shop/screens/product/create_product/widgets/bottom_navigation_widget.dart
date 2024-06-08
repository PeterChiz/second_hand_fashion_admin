import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/create_product_controller.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SHFRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Nút Hủy
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Hủy'),
          ),
          const SizedBox(width: SHFSizes.spaceBtwItems / 2),

          // Nút Lưu Thay Đổi
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => CreateProductController.instance.createProduct(),
              child: const Text('Lưu thay Đổi'),
            ),
          ),
        ],
      ),
    );
  }
}
