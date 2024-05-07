import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/authentication/controllers/admin_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../appbar/appbar.dart';
import '../../images/shf_rounded_image.dart';
import '../../shimmers/shimmer.dart';

/// Header widget for the application
class SHFHeader extends StatelessWidget implements PreferredSizeWidget {
  const SHFHeader({
    super.key,
    required this.scaffoldKey,
  });

  /// GlobalKey to access the Scaffold state
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = AdminController.instance;
    return Container(
      /// Background Color, Bottom Border
      decoration: const BoxDecoration(
        color: SHFColors.white,
        border: Border(bottom: BorderSide(color: SHFColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: SHFSizes.md, vertical: SHFSizes.sm),
      child: SHFAppBar(
        /// Mobile Menu
        leadingIcon: !SHFDeviceUtils.isDesktopScreen(context) ? Iconsax.menu : null,
        leadingOnPressed: !SHFDeviceUtils.isDesktopScreen(context) ? () => scaffoldKey.currentState?.openDrawer() : null,
        title: Row(
          children: [
            /// Search
            if (SHFDeviceUtils.isDesktopScreen(context))
              SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.search_normal), hintText: 'Search anything...'),
                ),
              ),
          ],
        ),
        actions: [
          // Search Icon on Mobile
          if (!SHFDeviceUtils.isDesktopScreen(context)) IconButton(icon: const Icon(Iconsax.search_normal), onPressed: () {}),

          // Notification Icon
          IconButton(icon: const Icon(Iconsax.notification), onPressed: () {}),
          const SizedBox(width: SHFSizes.spaceBtwItems / 2),

          /// User Data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// User Profile Image
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

              /// User Profile Data [Hide on Mobile]
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
