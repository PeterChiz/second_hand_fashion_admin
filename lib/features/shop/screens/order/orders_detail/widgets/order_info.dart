import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controllers/order/order_controller.dart';
import '../../../../models/order_model.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return SHFRoundedContainer(
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thông tin đơn hàng', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SHFSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đặt'),
                    Text(order.formattedOrderDate, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sản phẩm'),
                    Text('${order.items.length} sản phẩm', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                flex: SHFDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Trạng thái'),
                    Obx(
                          () {
                        if(controller.statusLoader.value) return const SHFShimmerEffect(width: double.infinity, height: 55);
                        return SHFRoundedContainer(
                          radius: SHFSizes.cardRadiusSm,
                          padding: const EdgeInsets.symmetric(horizontal: SHFSizes.sm, vertical: 0),
                          backgroundColor: SHFHelperFunctions.getOrderStatusColor(controller.orderStatus.value).withOpacity(0.1),
                          child: DropdownButton<OrderStatus>(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            value: controller.orderStatus.value,
                            onChanged: (OrderStatus? newValue) {
                              if (newValue != null) {
                                controller.updateOrderStatus(order, newValue);
                              }
                            },
                            items: OrderStatus.values.map((OrderStatus status) {
                              return DropdownMenuItem<OrderStatus>(
                                value: status,
                                child: Text(
                                  status.name.capitalize.toString(),
                                  style: TextStyle(color: SHFHelperFunctions.getOrderStatusColor(controller.orderStatus.value)),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tổng cộng'),
                    Text('\$${order.totalAmount}', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
