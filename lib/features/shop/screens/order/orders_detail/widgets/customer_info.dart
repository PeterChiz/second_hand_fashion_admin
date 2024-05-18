import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/order/order_detail_controller.dart';
import '../../../../models/order_model.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        SHFRoundedContainer(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thông tin khách hàng', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: SHFSizes.spaceBtwSections),
              Obx(
                    () {
                  return Row(
                    children: [
                      SHFRoundedImage(
                        padding: 0,
                        backgroundColor: SHFColors.primaryBackground,
                        image:
                        controller.customer.value.profilePicture.isNotEmpty ? controller.customer.value.profilePicture : SHFImages.user,
                        imageType: controller.customer.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                      ),
                      const SizedBox(width: SHFSizes.spaceBtwItems),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.customer.value.fullName,
                                style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 1),
                            Text(controller.customer.value.email, overflow: TextOverflow.ellipsis, maxLines: 1),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),

        // Contact Info
        Obx(
              () => SizedBox(
            width: double.infinity,
            child: SHFRoundedContainer(
              padding: const EdgeInsets.all(SHFSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Liên hệ', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: SHFSizes.spaceBtwSections),
                  Text(controller.customer.value.fullName, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                  Text(controller.customer.value.email, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                  Text(
                    controller.customer.value.formattedPhoneNo.isNotEmpty ? controller.customer.value.formattedPhoneNo : '(+1) *** ****',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),

        // Shipping Address
        SizedBox(
          width: double.infinity,
          child: SHFRoundedContainer(
            padding: const EdgeInsets.all(SHFSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Địa chỉ giao hàng', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: SHFSizes.spaceBtwSections),
                Text(order.address != null ? order.address!.name : '', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                Text(order.address != null ? order.address!.toString() : '', style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),

        // Billing Address
        SizedBox(
          width: double.infinity,
          child: SHFRoundedContainer(
            padding: const EdgeInsets.all(SHFSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Địa chỉ thanh toán', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: SHFSizes.spaceBtwSections),
                Text(order.address != null ? order.address!.name : '', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                Text(order.address != null ? order.address!.toString() : '', style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),
      ],
    );
  }
}
