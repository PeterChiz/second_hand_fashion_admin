import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants/sizes.dart';
import '../texts/page_heading.dart';

class SHFBreadcrumbsWithHeading extends StatelessWidget {
  const SHFBreadcrumbsWithHeading({
    super.key,
    required this.breadcrumbItems,
    required this.heading,
    this.returnToPreviousScreen = false,
  });

  // The heading for the page
  final String heading;

  // List of breadcrumb items representing the navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb trail
        Row(
          children: [
            // Dashboard link
            InkWell(
              onTap: () => Get.offAllNamed(SHFRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(SHFSizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                ),
              ),
            ),
            // Breadcrumb items
            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'), // Separator
                  InkWell(
                    // Last item should not be clickable
                    onTap: i == breadcrumbItems.length - 1 ? null : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(SHFSizes.xs),
                      // Format breadcrumb item: capitalize and remove leading '/'
                      child: Text(
                        i == breadcrumbItems.length - 1
                            ? breadcrumbItems[i].capitalize.toString()
                            : capitalize(breadcrumbItems[i].substring(1)),
                        style: Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: SHFSizes.sm),
        // Heading of the page
        Row(
          children: [
            if (returnToPreviousScreen) IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)),
            if (returnToPreviousScreen) const SizedBox(width: SHFSizes.spaceBtwItems),
            SHFPageHeading(heading: heading),
          ],
        ),
      ],
    );
  }

  // Function to capitalize the first letter of a string
  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
