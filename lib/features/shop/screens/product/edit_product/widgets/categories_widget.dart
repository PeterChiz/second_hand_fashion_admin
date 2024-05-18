
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../controllers/category/category_controller.dart';
import '../../../../controllers/product/edit_product_controller.dart';
import '../../../../models/category_model.dart';
import '../../../../models/product_model.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;

    return SHFRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Danh mục', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          FutureBuilder(
            future: productController.loadSelectedCategories(product.id),
            builder: (context, snapshot) {

              final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if(widget != null) return widget;

              return MultiSelectDialogField(
                buttonText: const Text("Thay đổi danh mục"),
                title: const Text("Danh mục"),
                initialValue: List<CategoryModel>.from(productController.selectedCategories),
                items: CategoryController.instance.allItems.map((category) => MultiSelectItem(category, category.name)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  productController.selectedCategories.assignAll(values);
                },
              );
            }
          ),
        ],
      ),
    );
  }
}
