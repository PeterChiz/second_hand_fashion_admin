import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'bindings/general_bindings.dart';
import 'routes/app_routes.dart';
import 'routes/route_observer.dart';
import 'utils/constants/colors.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setPathUrlStrategy();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const SHFApp());
}

class SHFApp extends StatelessWidget {
  const SHFApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: SHFTexts.appName,
      themeMode: ThemeMode.light,
      theme: SHFAppTheme.lightTheme,
      darkTheme: SHFAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      navigatorObservers: [RouteObservers()],
      scrollBehavior: MyCustomScrollBehavior(),
      getPages: SHFAppRoute.pages,
      home: const Scaffold(
        backgroundColor: SHFColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}