import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/create_banner_form.dart';

class CreateBannerDesktopScreen extends StatelessWidget {
  const CreateBannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              SHFBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Tạo Banner', breadcrumbItems: [SHFRoutes.categories, 'Tạo Banner']),
              SizedBox(height: SHFSizes.spaceBtwSections),

              // Form
              CreateBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
