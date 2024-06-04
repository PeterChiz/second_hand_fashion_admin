import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/order_model.dart';
import '../widgets/customer_info.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transaction.dart';

class OrderDetailDesktopScreen extends StatelessWidget {
  const OrderDetailDesktopScreen({super.key, required this.order});

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
              // Đường dẫn
              SHFBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: order.id, breadcrumbItems: const [SHFRoutes.orders, 'Chi tiết']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Nội dung
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thông tin đơn hàng bên trái
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Thông tin đơn hàng
                        OrderInfo(order: order),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Sản phẩm
                        OrderItems(order: order),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Giao dịch
                        OrderTransaction(order: order)
                      ],
                    ),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwSections),

                  // Đơn hàng bên phải
                  Expanded(
                    child: Column(
                      children: [
                        // Thông tin khách hàng
                        OrderCustomer(order: order),
                        const SizedBox(height: SHFSizes.spaceBtwSections),
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
