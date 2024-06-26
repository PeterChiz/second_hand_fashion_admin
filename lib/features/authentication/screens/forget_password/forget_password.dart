import 'package:flutter/material.dart';
import 'package:second_hand_fashion_admin/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';

/// Màn hình xử lý quá trình quên mật khẩu
class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SHFSiteTemplate(useLayout: false, desktop: ForgetPasswordScreenDesktop());
  }
}