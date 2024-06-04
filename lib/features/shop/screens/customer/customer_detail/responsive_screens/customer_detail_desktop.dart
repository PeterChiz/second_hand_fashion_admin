import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../personalization/models/user_model.dart';
import '../../../../controllers/customer/customer_detail_controller.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/shipping_address.dart';

class CustomerDetailDesktopScreen extends StatelessWidget {
  const CustomerDetailDesktopScreen({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.customer.value = customer;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Đường dẫn
              SHFBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: customer.fullName,
                  breadcrumbItems: const [SHFRoutes.customers, 'Chi tiết']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Nội dung chính
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thông tin khách hàng bên phải
                  Expanded(
                    child: Column(
                      children: [
                        // Thông tin khách hàng
                        CustomerInfo(customer: customer),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Địa chỉ giao hàng
                        const ShippingAddress(),
                      ],
                    ),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwSections),

                  // Đơn hàng của khách hàng bên trái
                  const Expanded(flex: 2, child: CustomerOrders()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
