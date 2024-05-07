import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/general_bindings.dart';
import 'routes/app_routes.dart';
import 'routes/route_observer.dart';
import 'utils/constants/colors.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
