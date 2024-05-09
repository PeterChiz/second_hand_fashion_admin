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

  // Tiêu đề của trang
  final String heading;

  // Danh sách các mục breadcrumb đại diện cho đường dẫn điều hướng
  final List<String> breadcrumbItems;

  // Cờ chỉ định liệu có bao gồm một nút để quay lại màn hình trước đó không
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dấu chân breadcrumb
        Row(
          children: [
            // Liên kết Dashboard
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
            // Các mục breadcrumb
            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'), // Dấu phân cách
                  InkWell(
                    // Mục cuối cùng không được nhấp vào
                    onTap: i == breadcrumbItems.length - 1 ? null : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(SHFSizes.xs),
                      // Định dạng mục breadcrumb: viết hoa chữ cái đầu và loại bỏ dấu '/'
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
        // Tiêu đề của trang
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

  // Hàm viết hoa chữ cái đầu của một chuỗi
  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
