import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/authentication/controllers/admin_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../appbar/appbar.dart';
import '../../images/shf_rounded_image.dart';
import '../../shimmers/shimmer.dart';

/// Widget tiêu đề cho ứng dụng
class SHFHeader extends StatelessWidget implements PreferredSizeWidget {
  const SHFHeader({super.key,
    required this.scaffoldKey,
  });

  /// GlobalKey để truy cập trạng thái Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = AdminController.instance;
    return Container(
      /// Màu nền, Đường viền dưới
      decoration: const BoxDecoration(
        color: SHFColors.white,
        border: Border(bottom: BorderSide(color: SHFColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: SHFSizes.md, vertical: SHFSizes.sm),
      child: SHFAppBar(
        /// Menu di động

        actions: [
          /// Dữ liệu Người dùng
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Hình ảnh Hồ sơ Người dùng
              Obx(
                    () => SHFRoundedImage(
                  width: 40,
                  padding: 2,
                  height: 40,
                  imageType: controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : SHFImages.user,
                ),
              ),

              const SizedBox(width: SHFSizes.sm),

              /// Dữ liệu Hồ sơ Người dùng [Ẩn trên di động]
              if (!SHFDeviceUtils.isMobileScreen(context))
                Obx(
                      () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.loading.value
                          ? const SHFShimmerEffect(width: 50, height: 13)
                          : Text(controller.user.value.fullName, style: Theme.of(context).textTheme.titleLarge),
                      controller.loading.value
                          ? const SHFShimmerEffect(width: 70, height: 13)
                          : Text(controller.user.value.email, style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SHFDeviceUtils.getAppBarHeight() + 15);
}
