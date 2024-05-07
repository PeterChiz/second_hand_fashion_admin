import 'package:flutter/material.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helpers/pricing_calculator.dart';
import '../../../../models/order_model.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(0.0, (previousValue, element) => previousValue + (element.price * element.quantity));
    return SHFRoundedContainer(
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          // Items
          ListView.separated(
            shrinkWrap: true,
            itemCount: order.items.length,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: SHFSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final item = order.items[index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SHFRoundedImage(
                          backgroundColor: SHFColors.primaryBackground,
                          imageType: item.image != null ? ImageType.network : ImageType.asset,
                          image: item.image ?? SHFImages.defaultImage,
                        ),
                        const SizedBox(width: SHFSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (item.selectedVariation != null)
                                Text(item.selectedVariation!.entries.map((e) => ('${e.key} : ${e.value} ')).toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwItems),
                  SizedBox(
                      width: SHFSizes.xl * 2,
                      child: Text('\$${item.price.toStringAsFixed(1)}', style: Theme.of(context).textTheme.bodyLarge)),
                  SizedBox(
                    width: SHFDeviceUtils.isMobileScreen(context) ? SHFSizes.xl * 1.4 : SHFSizes.xl * 2,
                    child: Text(item.quantity.toString(), style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  SizedBox(
                    width: SHFDeviceUtils.isMobileScreen(context) ? SHFSizes.xl * 1.4 : SHFSizes.xl * 2,
                    child: Text('\$${item.totalAmount}', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          // Items Total
          SHFRoundedContainer(
            padding: const EdgeInsets.all(SHFSizes.defaultSpace),
            backgroundColor: SHFColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal', style: Theme.of(context).textTheme.titleLarge),
                    Text('\$$subTotal', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount', style: Theme.of(context).textTheme.titleLarge),
                    Text('\$0.00', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${SHFPricingCalculator.calculateShippingCost(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${SHFPricingCalculator.calculateTax(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${SHFPricingCalculator.calculateTotalPrice(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
