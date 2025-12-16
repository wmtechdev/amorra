import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/presentation/controllers/admin/admin_auth_controller.dart';
import 'package:amorra/presentation/widgets/admin_web/common/web_text_field.dart';
import 'package:amorra/presentation/widgets/admin_web/common/web_button.dart';
import 'package:amorra/presentation/widgets/admin_web/common/web_card.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';

/// Admin Login Screen
/// Desktop-optimized login screen for admin dashboard
class AdminLoginScreen extends GetView<AdminAuthController> {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    if (!Get.isRegistered<AdminAuthController>()) {
      Get.put(AdminAuthController());
    }

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.lightGrey.withOpacity(0.3),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: WebSpacing.all(context, factor: 1.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: WebResponsive.isDesktop(context) ? 480 : double.infinity,
              ),
              child: WebCard(
                padding: WebSpacing.all(context, factor: 2.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo/Title Section
                    Column(
                      children: [
                        Container(
                          padding: WebSpacing.all(context, factor: 1.0),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.admin_panel_settings,
                            size: WebResponsive.iconSize(context, factor: 2.0),
                            color: AppColors.primary,
                          ),
                        ),
                        WebSpacing.large(context),
                        Text(
                          WebTexts.adminLoginTitle,
                          style: WebTextStyles.largeHeading(context).copyWith(
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        WebSpacing.medium(context),
                        Text(
                          WebTexts.adminLoginSubtitle,
                          style: WebTextStyles.bodyText(context).copyWith(
                            color: AppColors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    WebSpacing.extraLarge(context),

                    // Email Field
                    WebTextField(
                      controller: emailController,
                      label: WebTexts.adminEmailLabel,
                      hintText: WebTexts.adminEmailHint,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    WebSpacing.large(context),

                    // Password Field
                    WebTextField(
                      controller: passwordController,
                      label: WebTexts.adminPasswordLabel,
                      hintText: WebTexts.adminPasswordHint,
                      obscureText: true,
                    ),

                    WebSpacing.extraLarge(context),

                    // Sign In Button
                    Obx(() {
                      final isLoading = controller.isLoading.value;
                      return WebButton(
                        text: isLoading
                            ? WebTexts.adminSigningIn
                            : WebTexts.adminSignInButton,
                        onPressed: isLoading
                            ? null
                            : () => _handleSignIn(
                                  controller,
                                  emailController.text,
                                  passwordController.text,
                                ),
                        isLoading: isLoading,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignIn(
    AdminAuthController controller,
    String email,
    String password,
  ) {
    if (email.isEmpty || password.isEmpty) {
      controller.showError(
        WebTexts.messageValidationError,
        subtitle: WebTexts.messageValidationError,
      );
      return;
    }

    controller.signIn(email.trim(), password);
  }
}
