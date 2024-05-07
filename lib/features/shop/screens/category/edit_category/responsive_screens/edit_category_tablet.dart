import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/category_model.dart';
import '../widgets/edit_category_form.dart';

class EditCategoryTabletScreen extends StatelessWidget {
  const EditCategoryTabletScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SHFBreadcrumbsWithHeading(heading: 'Update Category', breadcrumbItems: [SHFRoutes.categories, 'Update Category']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Form
              EditCategoryForm(category: category,),
            ],
          ),
        ),
      ),
    );
  }
}
