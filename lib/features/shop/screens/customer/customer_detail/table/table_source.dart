import '../../../../../../common/widgets/containers/rounded_container.dart';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/helpers/pricing_calculator.dart';
import '../../../../controllers/customer/customer_detail_controller.dart';

class CustomerOrdersRows extends DataTableSource {
  final controller = CustomerDetailController.instance;

  @override
  DataRow? getRow(int index) {
    final order = controller.filteredCustomerOrders[index];
    final subTotal = order.items.fold<double>(0, (previousValue, element) => previousValue + (element.price * element.quantity));
    final totalPrice = SHFPricingCalculator.calculateTotalPrice(subTotal, order.address?.city ?? '');
    return DataRow2(
      onTap: () => Get.toNamed(SHFRoutes.orderDetails, arguments: order),
      selected: controller.selectedRows[index],
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: SHFColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text('${order.items.length} mặt hàng')),
        DataCell(
          SHFRoundedContainer(
            radius: SHFSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(vertical: SHFSizes.sm, horizontal: SHFSizes.md),
            backgroundColor: SHFHelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
            child: Text(order.status.name.capitalize.toString(), style: TextStyle(color: SHFHelperFunctions.getOrderStatusColor(order.status)),),
          ),
        ),
        DataCell(Text('$totalPriceđ')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredCustomerOrders.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
