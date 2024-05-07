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

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({super.key, required this.customer});

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
              // Breadcrumbs
              SHFBreadcrumbsWithHeading(
                  returnToPreviousScreen: true, heading: customer.fullName, breadcrumbItems: const [SHFRoutes.customers, 'Details']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Customer Info
              CustomerInfo(customer: customer),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Shipping Address
              const ShippingAddress(),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Left Side Customer Orders
              const CustomerOrders()
            ],
          ),
        ),
      ),
    );
  }
}
