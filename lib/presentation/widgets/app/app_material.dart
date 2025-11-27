import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_config.dart';
import '../../../core/config/routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../views/core/not_found_view.dart';

/// App Material Widget
/// Wraps the GetMaterialApp with all configurations
class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,

      // Theme Configuration
      themeMode: themeController.mode.value,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Routing Configuration
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.getRoutes(),
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const NotFoundView(),
      ),
    );
  }
}

