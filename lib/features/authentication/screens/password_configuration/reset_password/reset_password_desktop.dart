import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../common/widgets/layouts/templates/login_template.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/forget_password_controller.dart';

class ResetPasswordDesktopScreen extends StatelessWidget {
  const ResetPasswordDesktopScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      body: SHFLoginTemplate(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Get.offAllNamed(SHFRoutes.login), icon: const Icon(CupertinoIcons.clear)),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              /// Image with 60% of screen width
              const Image(image: AssetImage(SHFImages.deliveredEmailIllustration), width: 300, height: 300),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              /// Title & SubTitle
              Text(SHFTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              Text(email, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              Text(
                SHFTexts.changeYourPasswordSubTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              /// Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.back(), child: const Text(SHFTexts.done))),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: () => controller.resendPasswordResetEmail(email), child: const Text(SHFTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
