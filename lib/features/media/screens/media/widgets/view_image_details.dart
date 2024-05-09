import 'package:clipboard/clipboard.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/media_controller.dart';
import '../../../models/image_model.dart';

class ImagePopup extends StatelessWidget {
  // Thông tin chi tiết về hình ảnh cần hiển thị.
  final ImageModel image;

  // Constructor cho lớp ImagePopup.
  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        // Định hình hình dạng của hộp thoại.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.borderRadiusLg)),
        child: SHFRoundedContainer(
          // Đặt độ rộng của container được làm tròn dựa trên kích thước màn hình.
          width: SHFDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
          padding: const EdgeInsets.all(SHFSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị hình ảnh với tùy chọn đóng hộp thoại.
              SizedBox(
                child: Stack(
                  children: [
                    // Hiển thị hình ảnh với container được làm tròn.
                    SHFRoundedContainer(
                      backgroundColor: SHFColors.primaryBackground,
                      child: SHFRoundedImage(
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: SHFDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
                        imageType: ImageType.network,
                      ),
                    ),
                    // Nút đóng được đặt ở góc trên bên phải.
                    Positioned(top: 0, right: 0, child: IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.close_circle)))
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              // Hiển thị các siêu dữ liệu khác về hình ảnh.
              // Bao gồm tên ảnh, đường dẫn, loại, kích thước, ngày tạo và sửa đổi, và URL.
              // Cung cấp tùy chọn sao chép URL hình ảnh.
              Row(
                children: [
                  Expanded(child: Text('Tên ảnh', style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(flex: 3, child: Text(image.filename, style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),
              // Các hàng tương tự cho các thuộc tính siêu dữ liệu khác...

              // Hiển thị URL hình ảnh với tùy chọn sao chép.
              Row(
                children: [
                  Expanded(child: Text('URL hình ảnh:', style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      flex: 2,
                      child: Text(image.url, style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(image.url).then((value) => SHFLoaders.customToast(message: 'URL đã được sao chép!'));
                      },
                      child: const Text('Sao chép URL'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Hiển thị nút để xóa hình ảnh.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: () => MediaController.instance.removeCloudImageConfirmation(image),
                      child: const Text('Xóa hình ảnh', style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
