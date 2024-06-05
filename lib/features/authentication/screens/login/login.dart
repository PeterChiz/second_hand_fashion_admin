import 'package:flutter/material.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/login_desktop_tablet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SHFSiteTemplate(useLayout: false, desktop: LoginScreenDesktopTablet(),);
  }
}
