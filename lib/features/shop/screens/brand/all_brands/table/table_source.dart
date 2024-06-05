
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/brand/brand_controller.dart';

class BrandRows extends DataTableSource {
  final controller = BrandController.instance;

  @override
  DataRow? getRow(int index) {
    final brand = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              SHFRoundedImage(
                width: 50,
                height: 50,
                padding: SHFSizes.sm,
                image: brand.image,
                imageType: ImageType.network,
                borderRadius: SHFSizes.borderRadiusMd,
                backgroundColor: SHFColors.primaryBackground,
              ),
              const SizedBox(width: SHFSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  brand.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SHFColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SHFSizes.sm),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: SHFSizes.xs,
                direction: Axis.horizontal,
                children: brand.brandCategories != null
                    ? brand.brandCategories!
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: SHFSizes.xs),
                              child: Chip(label: Text(e.name), padding: const EdgeInsets.all(SHFSizes.xs)),
                            ))
                        .toList()
                    : [const SizedBox()],
              ),
            ),
          ),
        ),
        DataCell(brand.isFeatured ? const Icon(Iconsax.heart5, color: SHFColors.primary) : const Icon(Iconsax.heart)),
        DataCell(Text(brand.createdAt != null ? brand.formattedDate : '')),
        DataCell(
          SHFTableActionButtons(
            onEditPressed: () => Get.toNamed(SHFRoutes.editBrand, arguments: brand),
            onDeletePressed: () => controller.confirmAndDeleteItem(brand),
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
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
