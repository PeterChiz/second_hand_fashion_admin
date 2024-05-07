import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controllers/order/order_controller.dart';

class OrderRows extends DataTableSource {
  final controller = OrderController.instance;

  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(SHFRoutes.orderDetails, arguments: order),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SHFColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text('${order.items.length} Items')),
        DataCell(
          SHFRoundedContainer(
            radius: SHFSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(vertical: SHFSizes.sm, horizontal: SHFSizes.md),
            backgroundColor: SHFHelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(color: SHFHelperFunctions.getOrderStatusColor(order.status)),
            ),
          ),
        ),
        DataCell(Text('\$${order.totalAmount}')),
        DataCell(
          SHFTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(SHFRoutes.orderDetails, arguments: order),
            onDeletePressed: () => controller.confirmAndDeleteItem(order),
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
