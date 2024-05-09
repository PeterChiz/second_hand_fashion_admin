import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';

/// Widget để hiển thị các nút hành động cho các dòng bảng
class SHFTableActionButtons extends StatelessWidget {
  const SHFTableActionButtons({
    super.key,
    this.view = false,
    this.edit = true,
    this.delete = true,
    this.onViewPressed,
    this.onEditPressed,
    this.onDeletePressed,
  });

  /// Cờ để xác định xem nút xem có được kích hoạt hay không
  final bool view;

  /// Cờ để xác định xem nút chỉnh sửa có được kích hoạt hay không
  final bool edit;

  /// Cờ để xác định xem nút xóa có được kích hoạt hay không
  final bool delete;

  /// Hàm gọi lại khi nút xem được nhấn
  final VoidCallback? onViewPressed;

  /// Hàm gọi lại khi nút chỉnh sửa được nhấn
  final VoidCallback? onEditPressed;

  /// Hàm gọi lại khi nút xóa được nhấn
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (view)
          IconButton(
            onPressed: onViewPressed,
            icon: const Icon(Iconsax.eye, color: SHFColors.darkerGrey),
          ),
        if (edit)
          IconButton(
            onPressed: onEditPressed,
            icon: const Icon(Iconsax.pen_add, color: SHFColors.primary),
          ),
        if (delete)
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Iconsax.trash, color: SHFColors.error),
          ),
      ],
    );
  }
}
