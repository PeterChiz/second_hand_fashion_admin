import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/page_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';
import '../table/data_table.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SHFPageHeading(heading: 'Trang chủ'),
              const SizedBox(height: SHFSizes.spaceBtwSections),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                          () => SHFDashboardCard(
                        context: context,
                        title: 'Tổng doanh số',
                        subTitle:
                        '${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount)}đ',
                      ),
                    ),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwItems),
                  Expanded(
                    child: Obx(
                          () => SHFDashboardCard(
                        context: context,
                        title: 'Giá trị trung bình đơn hàng',
                        subTitle:
                        '${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(0)}đ',
                        icon: Iconsax.arrow_down,
                        color: SHFColors.error,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                          () => SHFDashboardCard(
                        context: context,
                        title: 'Tổng số đơn hàng',
                        subTitle: '${controller.orderController.allItems.length}',
                      ),
                    ),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwItems),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Biểu đồ hàng tuần
              const SHFWeeklySalesGraph(),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Đơn hàng
              SHFRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Đơn hàng gần đây', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: SHFSizes.spaceBtwSections),
                    const DashboardOrderTable(),
                  ],
                ),
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Biểu đồ trạng thái đơn hàng
              SHFRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Trạng thái đơn hàng', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: SHFSizes.spaceBtwSections),
                    const OrderStatusPieChart(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
