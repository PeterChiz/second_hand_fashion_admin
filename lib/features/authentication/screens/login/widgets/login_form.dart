import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../../routes/routes.dart';
import '../../../controllers/login_controller.dart';

class SHFLoginForm extends StatelessWidget {
  const SHFLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SHFSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            TextFormField(
              controller: controller.email,
              validator: SHFValidator.validateEmail,
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: SHFTexts.email),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields),

            /// Password
            Obx(
                  () => TextFormField(
                obscureText: controller.hidePassword.value,
                controller: controller.password,
                validator: (value) => SHFValidator.validationEmptyText('Mật khẩu', value),
                decoration: InputDecoration(
                  labelText: SHFTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields / 2),

            /// Nho mat khau va quen mat khau
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// nho mat khau
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = value!)),
                    const Text(SHFTexts.rememberMe),
                  ],
                ),

                /// quen mat khau
                TextButton(onPressed: () => Get.toNamed(SHFRoutes.forgetPassword), child: const Text(SHFTexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: SHFSizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              // Bỏ dấu chú thích dòng này để đăng ký admin
              // child: ElevatedButton(onPressed: () => controller.registerAdmin(), child: const Text('Đăng kí Admin')),
              child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), child: const Text(SHFTexts.signIn)),
            ),
          ],
        ),
      ),
    );
  }
}
