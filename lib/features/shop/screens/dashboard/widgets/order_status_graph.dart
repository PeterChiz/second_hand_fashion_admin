
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => controller.orderStatusData.isNotEmpty
              ? SizedBox(
                  height: 400,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: SHFDeviceUtils.isTabletScreen(context) ? 80 : 55,
                      startDegreeOffset: 180,
                      sections: controller.orderStatusData.entries.map((entry) {
                        final OrderStatus status = entry.key;
                        final int count = entry.value;

                        return PieChartSectionData(
                          color: SHFHelperFunctions.getOrderStatusColor(status),
                          value: count.toDouble(),
                          title: '$count',
                          radius: SHFDeviceUtils.isTabletScreen(context) ? 80 : 100,
                          titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        );
                      }).toList(),
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          // Handle touch events here if needed
                        },
                        enabled: true,
                      ),
                    ),
                  ),
                )
              : const SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SHFLoaderAnimation()])),
        ),

        // Show Status and Color Meta
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => DataTable(
              columns: const [
                DataColumn(label: Text('Trạng thái')),
                DataColumn(label: Text('Đơn hàng')),
                DataColumn(label: Text('Tổng')),
              ],
              rows: controller.orderStatusData.entries.map((entry) {
                final OrderStatus status = entry.key;
                final int count = entry.value;
                final double totalAmount = controller.totalAmounts[status]!;
                final String displayStatus = controller.getDisplayStatusName(status);

                return DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        SHFCircularContainer(width: 20, height: 20, backgroundColor: SHFHelperFunctions.getOrderStatusColor(status)),
                        Expanded(child: Text(' $displayStatus')),
                      ],
                    ),
                  ),
                  DataCell(Text(count.toString())),
                  DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')), // Format as needed
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Color getOrderStatusColor(OrderStatus status) {
    // Define colors for each order status
    switch (status) {
      case OrderStatus.pending:
        return SHFColors.primary.withOpacity(0.4);
      case OrderStatus.processing:
        return Colors.lightBlue;
      case OrderStatus.shipped:
        return SHFColors.primary;
      case OrderStatus.delivered:
        return CupertinoColors.activeBlue;
      case OrderStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
