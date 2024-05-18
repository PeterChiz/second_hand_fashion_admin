import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helpers/pricing_calculator.dart';
import '../../../../models/order_model.dart';


class OrderTransaction extends StatelessWidget {
  const OrderTransaction({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(0.0, (previousValue, element) => previousValue + (element.price * element.quantity));
    final totalPrice = SHFPricingCalculator.calculateTotalPrice(subTotal, order.address?.city ?? '');

    return SHFRoundedContainer(
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Giao dịch', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SHFSizes.spaceBtwSections),

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
                          Text('Thanh toán qua ${order.paymentMethod.capitalize}',
                              style: Theme.of(context).textTheme.titleLarge),
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
                    Text('Ngày', style: Theme.of(context).textTheme.labelMedium),
                    Text(order.formattedOrderDate, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tổng cộng', style: Theme.of(context).textTheme.labelMedium),
                    Text('$totalPrice\đ', style: Theme.of(context).textTheme.bodyLarge),
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