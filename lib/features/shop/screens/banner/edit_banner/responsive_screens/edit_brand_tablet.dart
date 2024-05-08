import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/banner_model.dart';
import '../widgets/edit_brand_form.dart';

class EditBannerTabletScreen extends StatelessWidget {
  const EditBannerTabletScreen({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SHFBreadcrumbsWithHeading(heading: 'Cập nhật Banner', breadcrumbItems: [SHFRoutes.categories, 'Cập nhật Banner']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Form
              EditBannerForm(banner: banner),
            ],
          ),
        ),
      ),
    );
  }
}
