import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../shimmers/shimmer.dart';

class SHFRoundedImage extends StatelessWidget {
  const SHFRoundedImage({
    super.key,
    this.image,
    this.file,
    this.border,
    this.width = 56,
    this.height = 56,
    this.memoryImage,
    this.overlayColor,
    required this.imageType,
    this.backgroundColor,
    this.padding = SHFSizes.sm,
    this.margin,
    this.fit = BoxFit.contain,
    this.applyImageRadius = true,
    this.borderRadius = SHFSizes.md,
  });

  final bool applyImageRadius;
  final BoxBorder? border;
  final double borderRadius;
  final BoxFit? fit;
  final String? image;
  final File? file;
  final ImageType imageType;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Uint8List? memoryImage;
  final double width, height, padding;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(border: border, color: backgroundColor, borderRadius: BorderRadius.circular(borderRadius)),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.file:
        imageWidget = _buildFileImage();
        break;
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    // Apply ClipRRect directly to the image widget
    return ClipRRect(
      borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
      child: imageWidget,
    );
  }

  // Hàm để tạo widget hình ảnh mạng
  Widget _buildNetworkImage() {
    if (image != null) {
      // Sử dụng CachedNetworkImage để tải và cache hình ảnh từ mạng hiệu quả // Không hoạt động trên Web nhưng chỉ để tải
      return CachedNetworkImage(
        fit: fit,
        color: overlayColor,
        imageUrl: image!,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) => SHFShimmerEffect(width: width, height: height),
      );
    } else {
      // Trả về container trống nếu không có hình ảnh được cung cấp
      return Container();
    }
  }

  // Hàm để tạo widget hình ảnh từ bộ nhớ
  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      // Hiển thị hình ảnh từ bộ nhớ sử dụng widget Image
      return Image(fit: fit, image: MemoryImage(memoryImage!), color: overlayColor);
    } else {
      // Trả về container trống nếu không có hình ảnh được cung cấp
      return Container();
    }
  }

  // Hàm để tạo widget hình ảnh từ file
  Widget _buildFileImage() {
    if (file != null) {
      // Hiển thị hình ảnh từ file sử dụng widget Image
      return Image(fit: fit, image: FileImage(file!), color: overlayColor);
    } else {
      // Trả về container trống nếu không có hình ảnh được cung cấp
      return Container();
    }
  }

  // Hàm để tạo widget hình ảnh từ asset
  Widget _buildAssetImage() {
    if (image != null) {
      // Hiển thị hình ảnh từ asset sử dụng widget Image
      return Image(fit: fit, image: AssetImage(image!), color: overlayColor);
    } else {
      // Trả về container trống nếu không có hình ảnh được cung cấp
      return Container();
    }
  }
}

