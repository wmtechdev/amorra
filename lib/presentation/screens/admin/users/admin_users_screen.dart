import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/presentation/controllers/admin/admin_user_controller.dart';
import 'package:amorra/data/models/user_model.dart';
import 'package:amorra/presentation/widgets/admin_web/common/page_header.dart';
import 'package:amorra/presentation/widgets/admin_web/common/empty_state.dart';
import 'package:amorra/presentation/widgets/admin_web/common/loading_state.dart';
import 'package:amorra/presentation/widgets/admin_web/common/filter_chips_row.dart';
import 'package:amorra/presentation/widgets/admin_web/users/user_table.dart';
import 'package:amorra/presentation/widgets/admin_web/users/user_list.dart';
import 'package:amorra/presentation/widgets/admin_web/users/user_detail_dialog.dart';
import 'package:amorra/presentation/widgets/admin_web/users/user_action_dialogs.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';

/// Admin Users Screen
/// Desktop-optimized user management screen
class AdminUsersScreen extends GetView<AdminUserController> {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminUserController());

    final searchController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header Section
        PageHeader(
          title: WebTexts.usersTitle,
          searchHint: WebTexts.usersSearchHint,
          searchController: searchController,
          onSearchChanged: (value) {
            controller.searchQuery.value = value;
            if (value.isEmpty) {
              controller.loadUsers();
            }
          },
          filterChips: FilterChipsRow(
            chips: [
              FilterChipItem(
                label: WebTexts.usersFilterAll,
                isSelected: controller.selectedFilter.value == 'all',
                onTap: () => controller.setFilter('all'),
              ),
              FilterChipItem(
                label: WebTexts.usersFilterBlocked,
                isSelected: controller.selectedFilter.value == 'blocked',
                onTap: () => controller.setFilter('blocked'),
              ),
              FilterChipItem(
                label: WebTexts.usersFilterSubscribed,
                isSelected: controller.selectedFilter.value == 'subscribed',
                onTap: () => controller.setFilter('subscribed'),
              ),
              FilterChipItem(
                label: WebTexts.usersFilterFree,
                isSelected: controller.selectedFilter.value == 'free',
                onTap: () => controller.setFilter('free'),
              ),
            ],
          ),
        ),

        WebSpacing.section(context),

        // Users Table/List
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const LoadingState();
            }

            if (controller.users.isEmpty) {
              return EmptyState(
                icon: Icons.people_outline,
                message: WebTexts.usersNoUsersFound,
              );
            }

            // Use DataTable for desktop, ListView for mobile
            if (WebResponsive.isDesktop(context)) {
              return UserTable(
                users: controller.users,
                onViewDetails: (user) => _showUserDetails(context, user),
                onBlockUnblock: (user) => _handleBlockUnblock(context, user),
                onGrantTrial: (user) => _handleGrantTrial(context, user),
                onDelete: (user) => _handleDeleteUser(context, user),
              );
            } else {
              return UserList(
                users: controller.users,
                onViewDetails: (user) => _showUserDetails(context, user),
                onBlockUnblock: (user) => _handleBlockUnblock(context, user),
                onGrantTrial: (user) => _handleGrantTrial(context, user),
                onDelete: (user) => _handleDeleteUser(context, user),
              );
            }
          }),
        ),
      ],
    );
  }

  void _showUserDetails(BuildContext context, UserModel user) {
    Get.dialog(UserDetailDialog(user: user));
  }

  void _handleBlockUnblock(BuildContext context, UserModel user) {
    UserActionDialogs.showBlockUnblockDialog(
      context,
      user,
      () {
        if (user.isBlocked) {
          controller.unblockUser(user.id);
        } else {
          controller.blockUser(user.id);
        }
      },
    );
  }

  void _handleGrantTrial(BuildContext context, UserModel user) {
    UserActionDialogs.showGrantTrialDialog(
      context,
      user,
      (days) => controller.grantFreeTrial(user.id, days: days),
    );
  }

  void _handleDeleteUser(BuildContext context, UserModel user) {
    UserActionDialogs.showDeleteDialog(
      context,
      user,
      () => controller.deleteUser(user.id),
    );
  }
}
