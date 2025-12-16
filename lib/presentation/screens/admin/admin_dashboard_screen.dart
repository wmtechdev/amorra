import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/presentation/controllers/admin/admin_auth_controller.dart';
import 'package:amorra/presentation/screens/admin/users/admin_users_screen.dart';
import 'package:amorra/presentation/screens/admin/subscriptions/admin_subscriptions_screen.dart';
import 'package:amorra/presentation/widgets/admin_web/common/web_sidebar.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';

/// Admin Dashboard Screen
/// Main screen with navigation between User Management and Subscription Management
class AdminDashboardScreen extends GetView<AdminAuthController> {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.lightGrey.withOpacity(0.3),
      appBar: AppBar(
        title: Text(
          WebTexts.adminDashboard,
          style: WebTextStyles.heading(context).copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: WebResponsive.isMobile(context)
            ? IconButton(
                icon: Icon(
                  Icons.menu,
                  size: WebResponsive.iconSize(context, factor: 0.9),
                ),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              )
            : null,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: WebResponsive.isDesktop(context) ? 12.0 : 8.0,
            ),
            child: IconButton(
              icon: Icon(
                Icons.logout,
                size: WebResponsive.iconSize(context, factor: 0.9),
              ),
              tooltip: WebTexts.adminSignOut,
              onPressed: () => _handleSignOut(controller),
            ),
          ),
        ],
      ),
      drawer: WebResponsive.isMobile(context)
          ? Drawer(
              width: WebResponsive.sidebarWidth(context),
              child: WebSidebar(
                selectedIndex: selectedIndex.value,
                onItemSelected: (index) {
                  selectedIndex.value = index;
                  scaffoldKey.currentState?.closeDrawer();
                },
                currentUserEmail: controller.currentAdminEmail,
              ),
            )
          : null,
      body: Row(
        children: [
          // Sidebar Navigation (Desktop only)
          if (WebResponsive.isDesktop(context))
            WebSidebar(
              selectedIndex: selectedIndex.value,
              onItemSelected: (index) => selectedIndex.value = index,
              currentUserEmail: controller.currentAdminEmail,
            ),

          // Main Content Area
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: WebResponsive.contentMaxWidth(context),
              ),
              margin: WebSpacing.all(context, factor: 1.0),
              child: Obx(() {
                if (selectedIndex.value == 0) {
                  return const AdminUsersScreen();
                } else {
                  return const AdminSubscriptionsScreen();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSignOut(AdminAuthController controller) {
    Get.dialog(
      AlertDialog(
        title: Text(
          WebTexts.adminSignOut,
          style: WebTextStyles.heading(Get.context!),
        ),
        content: Text(
          WebTexts.adminSignOutConfirm,
          style: WebTextStyles.bodyText(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(WebTexts.actionCancel),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.signOut();
              Get.offAllNamed('/admin-login');
            },
            child: Text(
              WebTexts.adminSignOut,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
