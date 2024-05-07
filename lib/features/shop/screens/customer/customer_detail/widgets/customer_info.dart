import 'package:flutter/material.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../personalization/models/user_model.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
    required this.customer,
  });

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return SHFRoundedContainer(
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Information', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          // Personal Info Card
          Row(
            children: [
              SHFRoundedImage(
                padding: 0,
                backgroundColor: SHFColors.primaryBackground,
                image: customer.profilePicture.isNotEmpty ? customer.profilePicture : SHFImages.user,
                imageType: customer.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
              ),
              const SizedBox(width: SHFSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(customer.fullName, style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 1),
                    Text(customer.email, overflow: TextOverflow.ellipsis, maxLines: 1),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Username')),
              const Text(':'),
              const SizedBox(width: SHFSizes.spaceBtwItems / 2),
              Expanded(child: Text(customer.userName, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: SHFSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Country')),
              const Text(':'),
              const SizedBox(width: SHFSizes.spaceBtwItems / 2),
              Expanded(child: Text('Pakistan', style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: SHFSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number')),
              const Text(':'),
              const SizedBox(width: SHFSizes.spaceBtwItems / 2),
              Expanded(child: Text(customer.phoneNumber, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          // Divider
          const Divider(),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          // Additional Details
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Last Order', style: Theme.of(context).textTheme.titleLarge),
                    const Text('7 Days Ago, #[36d54]'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Average Order Value', style: Theme.of(context).textTheme.titleLarge),
                    const Text('\$352'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          // Additional Details Cont.
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Registered', style: Theme.of(context).textTheme.titleLarge),
                    Text(customer.formattedDate),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Marketing', style: Theme.of(context).textTheme.titleLarge),
                    const Text('Subscribed'),
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
