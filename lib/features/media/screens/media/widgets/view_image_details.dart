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
  // The image model to display detailed information about.
  final ImageModel image;

  // Constructor for the ImagePopup class.
  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        // Define the shape of the dialog.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.borderRadiusLg)),
        child: SHFRoundedContainer(
          // Set the width of the rounded container based on the screen size.
          width: SHFDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
          padding: const EdgeInsets.all(SHFSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image with an option to close the dialog.
              SizedBox(
                child: Stack(
                  children: [
                    // Display the image with rounded container.
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
                    // Close icon button positioned at the top-right corner.
                    Positioned(top: 0, right: 0, child: IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.close_circle)))
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              // Display various metadata about the image.
              // Includes image name, path, type, size, creation and modification dates, and URL.
              // Also provides an option to copy the image URL.
              Row(
                children: [
                  Expanded(child: Text('Image Name:', style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(flex: 3, child: Text(image.filename, style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),
              // Similar rows for other metadata properties...

              // Display the image URL with an option to copy it.
              Row(
                children: [
                  Expanded(child: Text('Image URL:', style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      flex: 2,
                      child: Text(image.url, style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(image.url).then((value) => SHFLoaders.customToast(message: 'URL copied!'));
                      },
                      child: const Text('Copy URL'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Display a button to delete the image.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: () => MediaController.instance.removeCloudImageConfirmation(image),
                      child: const Text('Delete Image', style: TextStyle(color: Colors.red)),
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
