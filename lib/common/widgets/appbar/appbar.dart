import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class SHFAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Thanh ứng dụng tùy chỉnh để đạt được một mục tiêu thiết kế mong muốn.
  /// - Đặt [title] để có một tiêu đề tùy chỉnh.
  /// - [showBackArrow] để chuyển đổi tính hiển thị của mũi tên quay lại.
  /// - [leadingIcon] để có một biểu tượng dẫn tùy chỉnh.
  /// - [leadingOnPressed] là hàm gọi lại cho sự kiện nhấn biểu tượng dẫn.
  /// - [actions] để thêm một danh sách các widget hành động.
  /// - Khoảng lề ngang của thanh ứng dụng có thể được tùy chỉnh bên trong widget này.
  const SHFAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? SHFColors.white : SHFColors.dark))
          : leadingIcon != null
          ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
          : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SHFDeviceUtils.getAppBarHeight());
}
