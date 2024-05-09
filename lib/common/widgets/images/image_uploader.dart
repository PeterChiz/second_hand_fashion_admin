import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/icons/shf_circular_icon.dart';
import '../../../../../../common/widgets/images/shf_circular_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import 'shf_rounded_image.dart';

/// Widget để tải lên hình ảnh với chức năng chỉnh sửa tùy chọn
class SHFImageUploader extends StatelessWidget {
  const SHFImageUploader({
    super.key,
    this.image,
    this.onIconButtonPressed,
    this.memoryImage,
    this.width = 100,
    this.height = 100,
    required this.imageType,
    this.circular = false,
    this.icon = Iconsax.edit_2,
    this.top,
    this.bottom = 0,
    this.right,
    this.left = 0,
  });

  /// Cho biết liệu có hiển thị hình ảnh dưới dạng hình tròn hay không
  final bool circular;

  /// URL hoặc đường dẫn của hình ảnh để hiển thị
  final String? image;

  /// Loại hình ảnh (mạng, tài nguyên, bộ nhớ, v.v.)
  final ImageType imageType;

  /// Chiều rộng của widget tải lên hình ảnh
  final double width;

  /// Chiều cao của widget tải lên hình ảnh
  final double height;

  /// Dữ liệu byte của hình ảnh (cho hình ảnh trong bộ nhớ)
  final Uint8List? memoryImage;

  /// Biểu tượng để hiển thị trên widget tải lên hình ảnh
  final IconData icon;

  /// Khoảng cách từ đỉnh của widget
  final double? top;

  /// Khoảng cách từ đáy của widget
  final double? bottom;

  /// Khoảng cách từ phải của widget
  final double? right;

  /// Khoảng cách từ trái của widget
  final double? left;

  /// Hàm gọi lại khi nút biểu tượng được nhấn
  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hiển thị hình ảnh dưới dạng hình tròn hoặc hình vuông
        circular
            ? SHFCircularImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: SHFColors.primaryBackground,
              )
            : SHFRoundedImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: SHFColors.primaryBackground,
              ),
        // Hiển thị nút biểu tượng chỉnh sửa trên hình ảnh
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: SHFCircularIcon(
            icon: icon,
            size: SHFSizes.md,
            color: Colors.white,
            onPressed: onIconButtonPressed,
            backgroundColor: SHFColors.primary.withOpacity(0.9),
          ),
        )
      ],
    );
  }
}
