import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/order/order_controller.dart';
import '../table/data_table.dart';
import '../widgets/table_header.dart';

class OrdersMobileScreen extends StatelessWidget {
  const OrdersMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SHFBreadcrumbsWithHeading(heading: 'Orders', breadcrumbItems: ['Orders']),
              const SizedBox(height: SHFSizes.spaceBtwSections),
              // Table Body
              Obx(() {
                if (controller.isLoading.value) return const SHFLoaderAnimation();
                return const SHFRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      OrderTableHeader(),
                      SizedBox(height: SHFSizes.spaceBtwItems),

                      // Table
                      OrderTable(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
