import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/order_model.dart';
import '../widgets/customer_info.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transaction.dart';

class OrderDetailMobileScreen extends StatelessWidget {
  const OrderDetailMobileScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              SHFBreadcrumbsWithHeading(
                  returnToPreviousScreen: true, heading: order.id, breadcrumbItems: const [SHFRoutes.orders, 'Chi tiết']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Body
              OrderInfo(order: order),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Items
              OrderItems(order: order),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Transactions
              OrderTransaction(order: order),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Right Side Order Orders
              OrderCustomer(order: order),
              const SizedBox(height: SHFSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
