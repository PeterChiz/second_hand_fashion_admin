import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';

/// Một widget container tròn với tùy chọn child, border, và styling.
class SHFCircularContainer extends StatelessWidget {
  /// Tạo một container tròn.
  ///
  /// Tham số:
  ///   - child: Widget child tùy chọn để đặt bên trong container.
  ///   - margin: Khoảng cách lề xung quanh container.
  ///   - padding: Khoảng cách lề bên trong container.
  ///   - width: Chiều rộng của container.
  ///   - height: Chiều cao của container.
  ///   - radius: Bán kính của border tròn.
  ///   - showBorder: Có hiển thị border xung quanh container không.
  ///   - backgroundColor: Màu nền của container.
  ///   - borderColor: Màu của border (nếu [showBorder] là true).
  const SHFCircularContainer({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.showBorder = false,
    this.backgroundColor = SHFColors.white,
    this.borderColor = SHFColors.borderPrimary,
  });

  final Widget? child;
  final double? width;
  final double radius;
  final double? height;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
