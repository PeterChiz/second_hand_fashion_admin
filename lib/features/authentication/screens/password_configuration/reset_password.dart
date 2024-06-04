// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../common/widgets/appbar/appbar.dart';
// import '../../../../utils/constants/image_strings.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../../../utils/helpers/helper_functions.dart';
// import '../../controllers/forget_password_controller.dart';
// import '../login/login.dart';
//
// class ResetPasswordScreen extends StatelessWidget {
//   const ResetPasswordScreen({super.key, required this.email});
//
//   final String email;
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ForgetPasswordController());
//     return Scaffold(
//       /// Thanh ứng dụng để quay lại hoặc đóng tất cả các màn hình và đi đến Màn hình Đăng nhập
//       appBar: SHFAppBar(
//         actions: [
//           IconButton(onPressed: () => Get.offAll(const LoginScreen()), icon: const Icon(CupertinoIcons.clear)),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(SHFSizes.defaultSpace),
//           child: Column(
//             children: [
//               /// Hình ảnh chiếc hộp thư với 60% chiều rộng màn hình
//               Image(
//                 image: const AssetImage(SHFImages.deliveredEmailIllustration),
//                 width: SHFHelperFunctions.screenWidth() * 0.6,
//               ),
//               const SizedBox(height: SHFSizes.spaceBtwSections),
//
//               /// Tiêu đề & Phụ đề
//               Text(SHFTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
//               const SizedBox(height: SHFSizes.spaceBtwItems),
//               Text('buithienchi209@gmail.com', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge),
//               const SizedBox(height: SHFSizes.spaceBtwItems),
//               Text(
//                 SHFTexts.changeYourPasswordSubTitle,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.labelMedium,
//               ),
//               const SizedBox(height: SHFSizes.spaceBtwSections),
//
//               /// Các nút
//               SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()), child: const Text(SHFTexts.done))),
//               const SizedBox(height: SHFSizes.spaceBtwItems),
//               SizedBox(
//                   width: double.infinity,
//                   child: TextButton(onPressed: () => controller.resendPasswordResetEmail(email), child: const Text(SHFTexts.resendEmail))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
