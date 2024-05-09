import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/customer/customer_detail_controller.dart';
import '../table/data_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerOrders();
    return SHFRoundedContainer(
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Obx(
        () {
          if (controller.ordersLoading.value) return const SHFLoaderAnimation();
          if (controller.allCustomerOrders.isEmpty) {
            return SHFAnimationLoaderWidget(text: 'No Orders Found', animation: SHFImages.packageAnimation);
          }

          final totalAmount = controller.allCustomerOrders.fold(0.0,
              (previousValue, element) => previousValue + element.totalAmount);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Orders',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Total Spent '),
                        TextSpan(
                            text: '\$${totalAmount.toString()}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: SHFColors.primary)),
                        TextSpan(
                            text:
                                ' on ${controller.allCustomerOrders.length} Orders',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              TextFormField(
                controller: controller.searchTextController,
                onChanged: (query) => controller.searchQuery(query),
                decoration: const InputDecoration(
                    hintText: 'Search Orders',
                    prefixIcon: Icon(Iconsax.search_normal)),
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),
              const CustomerOrderTable(),
            ],
          );
        },
      ),
    );
  }
}
