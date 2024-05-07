import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/text_strings.dart';
import '../../personalization/models/user_model.dart';
import 'admin_controller.dart';

/// Controller for handling login functionality
class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Whether the login process is currently loading
  final isLoading = false.obs;

  /// Whether the password should be hidden
  final hidePassword = true.obs;

  /// Whether the user has selected "Remember Me"
  final rememberMe = false.obs;

  /// Local storage instance for remembering email and password
  final localStorage = GetStorage();

  /// Text editing controller for the email field
  final email = TextEditingController();

  /// Text editing controller for the password field
  final password = TextEditingController();

  /// Form key for the login form
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // Retrieve stored email and password if "Remember Me" is selected
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// Handles email and password sign-in process
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      isLoading.value = true;
      SHFFullScreenLoader.openLoadingDialog('Logging you in...', SHFImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email & Password Authentication
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Fetch user details and assign to UserController
      final user = await AdminController.instance.fetchUserDetails();

      // Remove Loader
      SHFFullScreenLoader.stopLoading();

      // If user is not admin, logout and return
      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        SHFLoaders.errorSnackBar(title: 'Not Authorized', message: 'You are not authorized or do have access. Contact Admin');
      } else {
        // Redirect
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      isLoading.value = false;
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Handles registration of admin user
  Future<void> registerAdmin() async {
    try {
      // Start Loading
      isLoading.value = true;
      SHFFullScreenLoader.openLoadingDialog('Registering Admin Account...', SHFImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Register user using Email & Password Authentication
      await AuthenticationRepository.instance.registerWithEmailAndPassword(SHFTexts.adminEmail, SHFTexts.adminPassword);

      // Create admin record in the Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'CwT',
          lastName: 'Admin',
          email: SHFTexts.adminEmail,
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ),
      );

      // Remove Loader
      SHFFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      isLoading.value = false;
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
