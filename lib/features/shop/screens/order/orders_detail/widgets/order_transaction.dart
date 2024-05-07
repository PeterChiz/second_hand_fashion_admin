import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../models/order_model.dart';


class OrderTransaction extends StatelessWidget {
  const OrderTransaction({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return SHFRoundedContainer(
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transactions', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          // Adjust as per your needs
          Row(
            children: [
              Expanded(
                flex: SHFDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                    const SHFRoundedImage(imageType: ImageType.asset, image: SHFImages.paypal),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Payment via ${order.paymentMethod.capitalize}',
                              style: Theme.of(context).textTheme.titleLarge),
                          // Adjust your Payment Method Fee if any
                          Text('${order.paymentMethod.capitalize} fee \$25',
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date', style: Theme.of(context).textTheme.labelMedium),
                    Text('April 21, 2025', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total', style: Theme.of(context).textTheme.labelMedium),
                    Text('\$${order.totalAmount}', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}