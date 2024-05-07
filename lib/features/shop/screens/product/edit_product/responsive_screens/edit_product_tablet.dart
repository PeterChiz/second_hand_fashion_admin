import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateProductTabletScreen extends StatelessWidget {
  const CreateProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SHFBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Create Product', breadcrumbItems: [SHFRoutes.products, 'Create Product']),
              SizedBox(height: SHFSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
