import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../personalization/models/address_model.dart';
import '../../../../controllers/customer/customer_detail_controller.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddresses();

    return Obx(
      () {
        if (controller.addressesLoading.value) return const SHFLoaderAnimation();

        AddressModel selectedAddress = AddressModel.empty();
        if (controller.customer.value.addresses != null) {
          if (controller.customer.value.addresses!.isNotEmpty) {
            selectedAddress = controller.customer.value.addresses!
                .singleWhere((element) => element.selectedAddress);
          }
        }

        return SHFRoundedContainer(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Địa chỉ giao hàng',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Meta Data
              Row(
                children: [
                  const SizedBox(width: 120, child: Text('Tên')),
                  const Text(':'),
                  const SizedBox(width: SHFSizes.spaceBtwItems / 2),
                  Expanded(
                      child: Text(selectedAddress.name,
                          style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              Row(
                children: [
                  const SizedBox(width: 120, child: Text('Số điện thoại')),
                  const Text(':'),
                  const SizedBox(width: SHFSizes.spaceBtwItems / 2),
                  Expanded(
                      child: Text(selectedAddress.phoneNumber,
                          style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              Row(
                children: [
                  const SizedBox(width: 120, child: Text('Địa chỉ')),
                  const Text(':'),
                  const SizedBox(width: SHFSizes.spaceBtwItems / 2),
                  Expanded(
                      child: Text(
                          selectedAddress.id.isNotEmpty
                              ? selectedAddress.toString()
                              : '',
                          style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
