import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/routes.dart';

class BannerTableHeader extends StatelessWidget {
  const BannerTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: ElevatedButton(onPressed: () => Get.toNamed(SHFRoutes.createBanner), child: const Text('Tạo Banner mới')),
        ),
      ],
    );
  }
}
