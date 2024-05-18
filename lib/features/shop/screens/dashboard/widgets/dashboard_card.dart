import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFDashboardCard extends StatelessWidget {
  const SHFDashboardCard({
    super.key,
    required this.context,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = SHFColors.success,
    this.onTap,
  });

  final BuildContext context;
  final String title, subTitle;
  final IconData icon;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SHFRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(SHFSizes.lg),
      child: Column(
        children: [
          /// Heading
          SHFSectionHeading(title: title, textColor: SHFColors.textSecondary),
          const SizedBox(height: SHFSizes.spaceBtwSections),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subTitle, style: Theme.of(context).textTheme.headlineMedium),


            ],
          ),
        ],
      ),
    );
  }
}
