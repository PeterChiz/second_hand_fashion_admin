import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

/// Widget để hiển thị chỉ báo tải hoạt hình với văn bản tùy chọn và nút hành động.
class SHFAnimationLoaderWidget extends StatelessWidget {
  /// Hàm tạo mặc định cho SHFAnimationLoaderWidget.
  ///
  /// Parameters:
  ///   - text: Văn bản được hiển thị dưới hoạt hình.
  ///   - animation: Đường dẫn đến tệp hoạt hình Lottie.
  ///   - showAction: Có hiển thị nút hành động dưới văn bản hay không.
  ///   - actionText: Văn bản được hiển thị trên nút hành động.
  ///   - onActionPressed: Hàm gọi lại được thực thi khi nút hành động được nhấn.
  const SHFAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed, this.height, this.width, this.style,
  });

  final String text;
  final TextStyle? style;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, height: height ?? MediaQuery.of(context).size.height * 0.5, width: width), // Hiển thị hoạt hình Lottie
          const SizedBox(height: SHFSizes.defaultSpace),
          Text(
            text,
            style: style ?? Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SHFSizes.defaultSpace),
          showAction
              ? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: SHFColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: SHFColors.light),
              ),
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}
