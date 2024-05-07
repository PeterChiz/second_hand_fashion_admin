import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/product_controller.dart';

class ProductsRows extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(SHFRoutes.editProduct, arguments: product),
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              SHFRoundedImage(
                width: 50,
                height: 50,
                padding: SHFSizes.xs,
                image: product.thumbnail,
                imageType: ImageType.network,
                borderRadius: SHFSizes.borderRadiusMd,
                backgroundColor: SHFColors.primaryBackground,
              ),
              const SizedBox(width: SHFSizes.spaceBtwItems),
              Flexible(
                  child: Text(product.title,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge!
                          .apply(color: SHFColors.primary))),
            ],
          ),
        ),
        DataCell(Text(controller.getProductStockTotal(product))),
        DataCell(
          Row(
            children: [
              SHFRoundedImage(
                width: 35,
                height: 35,
                padding: SHFSizes.xs,
                borderRadius: SHFSizes.borderRadiusMd,
                backgroundColor: SHFColors.primaryBackground,
                imageType:
                    product.brand != null ? ImageType.network : ImageType.asset,
                image: product.brand != null
                    ? product.brand!.image
                    : SHFImages.defaultImage,
              ),
              const SizedBox(width: SHFSizes.spaceBtwItems),
              Flexible(
                  child: Text(product.brand != null ? product.brand!.name : '',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge!
                          .apply(color: SHFColors.primary))),
            ],
          ),
        ),
        DataCell(Text('\$${controller.getProductPrice(product)}')),
        DataCell(Text(product.formattedDate)),
        DataCell(
          SHFTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(SHFRoutes.editProduct, arguments: product),
            onDeletePressed: () => controller.confirmAndDeleteItem(product),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
