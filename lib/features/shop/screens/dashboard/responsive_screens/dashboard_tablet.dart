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
  const DashboardTabletScreen({super.key});

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
              const SHFPageHeading(heading: 'Dashboard'),
              const SizedBox(height: SHFSizes.spaceBtwSections),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => SHFDashboardCard(
                        stats: 25,
                        context: context,
                        title: 'Sales total',
                        subTitle:
                            '\$${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount)}',
                      ),
                    ),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwItems),
                  Expanded(
                    child: Obx(
                      () => SHFDashboardCard(
                        stats: 15,
                        context: context,
                        title: 'Average Order Value',
                        subTitle:
                            '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
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
                        stats: 44,
                        context: context,
                        title: 'Total Orders',
                        subTitle: '\$${controller.orderController.allItems.length}',
                      ),
                    ),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwItems),
                  Expanded(child: SHFDashboardCard(context: context, title: 'Visitors', subTitle: '25,035', stats: 2)),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Weekly Graphs
              const SHFWeeklySalesGraph(),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Orders
              SHFRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: SHFSizes.spaceBtwSections),
                    const DashboardOrderTable(),
                  ],
                ),
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Order Status Pie Graph
              SHFRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Orders Status', style: Theme.of(context).textTheme.headlineSmall),
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
