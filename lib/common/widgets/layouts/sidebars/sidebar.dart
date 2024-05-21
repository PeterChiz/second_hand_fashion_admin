import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../images/shf_circular_image.dart';
import 'menu/menu_item.dart';

/// Tiện ích thanh bên cho menu điều hướng
class SHFSidebar extends StatelessWidget {
  const SHFSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: SHFColors.white,
          border: Border(right: BorderSide(width: 1, color: SHFColors.grey)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SHFCircularImage(width: 100, height: 100, image: SHFImages.darkAppLogo, padding: 0, backgroundColor: Colors.transparent),
              const SizedBox(height: SHFSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SHFSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('MENU', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2)),
                    // Các mục menu
                    const SHFMenuItem(route: SHFRoutes.dashboard, icon: Iconsax.status, itemName: 'Doanh thu'),
                    const SHFMenuItem(route: SHFRoutes.media, icon: Iconsax.image, itemName: 'Kho ảnh'),
                    const SHFMenuItem(route: SHFRoutes.banners, icon: Iconsax.picture_frame, itemName: 'Banner'),
                    const SHFMenuItem(route: SHFRoutes.products, icon: Iconsax.shopping_bag, itemName: 'Sản phẩm'),
                    const SHFMenuItem(route: SHFRoutes.categories, icon: Iconsax.category_2, itemName: 'Danh mục'),
                    const SHFMenuItem(route: SHFRoutes.brands, icon: Iconsax.dcube, itemName: 'Thương hiệu'),
                    const SHFMenuItem(route: SHFRoutes.customers, icon: Iconsax.profile_2user, itemName: 'Khách hàng'),
                    const SHFMenuItem(route: SHFRoutes.orders, icon: Iconsax.box, itemName: 'Đơn hàng'),
                    const SizedBox(height: SHFSizes.spaceBtwItems),
                    Text('KHÁC', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2)),

                    const SHFMenuItem(route: 'logout', icon: Iconsax.logout, itemName: 'Đăng xuất'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
