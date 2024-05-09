import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

/// Một widget container với góc bo tròn và các thuộc tính có thể tùy chỉnh.
class SHFRoundedContainer extends StatelessWidget {
  /// Tạo một container với góc bo tròn và các thuộc tính có thể tùy chỉnh.
  ///
  /// Tham số:
  ///   - width: Chiều rộng của container.
  ///   - height: Chiều cao của container.
  ///   - radius: Bán kính của góc bo tròn.
  ///   - padding: Khoảng cách lề bên trong container.
  ///   - margin: Khoảng cách lề xung quanh container.
  ///   - child: Widget sẽ được đặt bên trong container.
  ///   - backgroundColor: Màu nền của container.
  ///   - borderColor: Màu của viền container.
  ///   - showBorder: Cờ xác định liệu container có nên có viền không.
  const SHFRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.showShadow = true,
    this.showBorder = false,
    this.padding = const EdgeInsets.all(SHFSizes.md),
    this.borderColor = SHFColors.borderPrimary,
    this.radius = SHFSizes.cardRadiusLg,
    this.backgroundColor = SHFColors.white,
    this.onTap,
  });

  final Widget? child;
  final double radius;
  final double? width;
  final double? height;
  final bool showBorder;
  final bool showShadow;
  final Color borderColor;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color: SHFColors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: child,
      ),
    );
  }
}
