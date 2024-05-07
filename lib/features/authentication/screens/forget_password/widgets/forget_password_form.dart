import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../controllers/forget_password_controller.dart';


class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Headings
        IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)),
        const SizedBox(height: SHFSizes.spaceBtwItems),
        Text(SHFTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: SHFSizes.spaceBtwItems),
        Text(SHFTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: SHFSizes.spaceBtwSections * 2),

        /// Text field
        Form(
          key: controller.forgetPasswordFormKey,
          child: TextFormField(
            controller: controller.email,
            validator: SHFValidator.validateEmail,
            decoration: const InputDecoration(labelText: SHFTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
          ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),

        /// Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(), child: const Text(SHFTexts.submit)),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections * 2),
      ],
    );
  }
}
