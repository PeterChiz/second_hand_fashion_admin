import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/brand/brand_controller.dart';
import '../../../../controllers/product/edit_product_controller.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy các thể hiện của controllers
    final controller = Get.put(EditProductController());
    final brandController = Get.put(BrandController());

    // Lấy danh sách thương hiệu nếu danh sách đang trống
    if (brandController.allItems.isEmpty) {
      brandController.fetchItems();
    }

    return SHFRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nhãn thương hiệu
          Text('Thương hiệu', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          // TypeAheadField để chọn thương hiệu
          Obx(
                () => brandController.isLoading.value
                ? const SHFShimmerEffect(width: double.infinity, height: 50)
                : TypeAheadField(
              controller: controller.brandTextField,
              builder: (context, ctr, focusNode) {
                return TextFormField(
                  focusNode: focusNode,
                  controller: ctr,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Thay đổi thương hiệu',
                    suffixIcon: Icon(Iconsax.box),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                // Trả về các gợi ý thương hiệu đã được lọc dựa trên mẫu tìm kiếm
                return brandController.allItems.where((brand) => brand.name.contains(pattern)).toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.name),
                );
              },
              onSelected: (suggestion) {
                controller.selectedBrand.value = suggestion;
                controller.brandTextField.text = suggestion.name;
              },
            ),
          ),
        ],
      ),
    );
  }
}
