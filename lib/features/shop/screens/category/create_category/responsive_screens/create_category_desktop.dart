import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/create_category_form.dart';

class CreateCategoryDesktopScreen extends StatelessWidget {
  const CreateCategoryDesktopScreen({super.key});

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
              SHFBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Tạo danh mục', breadcrumbItems: [SHFRoutes.categories, 'Tạo danh mục']),
              SizedBox(height: SHFSizes.spaceBtwSections),

              // Form
              CreateCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
