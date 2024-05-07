import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/order_model.dart';
import '../widgets/customer_info.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transaction.dart';

class OrderDetailTabletScreen extends StatelessWidget {
  const OrderDetailTabletScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(OrderDetailController());
    // controller.order.value = order;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              SHFBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: order.id, breadcrumbItems: const [SHFRoutes.orders, 'Details']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Order Information
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Order Info
                        OrderInfo(order: order),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Items
                        OrderItems(order: order),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Transactions
                        OrderTransaction(order: order)
                      ],
                    ),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwSections),

                  // Right Side Order Orders
                  Expanded(
                    child: Column(
                      children: [
                        // Customer Info
                        OrderCustomer(order: order),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Shipping Address
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
