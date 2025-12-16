import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/presentation/controllers/admin/admin_subscription_controller.dart';
import 'package:amorra/data/models/subscription_model.dart';
import 'package:amorra/presentation/widgets/admin_web/common/page_header.dart';
import 'package:amorra/presentation/widgets/admin_web/common/empty_state.dart';
import 'package:amorra/presentation/widgets/admin_web/common/loading_state.dart';
import 'package:amorra/presentation/widgets/admin_web/common/filter_chips_row.dart';
import 'package:amorra/presentation/widgets/admin_web/common/analytics_cards_row.dart';
import 'package:amorra/presentation/widgets/admin_web/subscriptions/subscription_table.dart';
import 'package:amorra/presentation/widgets/admin_web/subscriptions/subscription_list.dart';
import 'package:amorra/presentation/widgets/admin_web/subscriptions/subscription_detail_dialog.dart';
import 'package:amorra/presentation/widgets/admin_web/subscriptions/subscription_action_dialogs.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/constants/app_constants.dart';

/// Admin Subscriptions Screen
/// Desktop-optimized subscription management screen
class AdminSubscriptionsScreen extends GetView<AdminSubscriptionController> {
  const AdminSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminSubscriptionController());

    final searchController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Analytics Cards
        Obx(() {
          final analytics = controller.subscriptionAnalytics;
          if (analytics.isEmpty) {
            return const SizedBox.shrink();
          }

          return AnalyticsCardsRow(
            cards: [
              AnalyticsCardItem(
                label: WebTexts.analyticsTotal,
                value: analytics['totalSubscriptions']?.toString() ?? '0',
                color: AppColors.primary,
                icon: Icons.subscriptions,
              ),
              AnalyticsCardItem(
                label: WebTexts.analyticsActive,
                value: analytics['activeSubscriptions']?.toString() ?? '0',
                color: AppColors.success,
                icon: Icons.check_circle,
              ),
              AnalyticsCardItem(
                label: WebTexts.analyticsCancelled,
                value: analytics['cancelledSubscriptions']?.toString() ?? '0',
                color: Colors.orange,
                icon: Icons.cancel,
              ),
              AnalyticsCardItem(
                label: WebTexts.analyticsMRR,
                value:
                    '\$${((analytics['monthlyRevenue'] ?? 0.0) as double).toStringAsFixed(2)}',
                color: Colors.blue,
                icon: Icons.attach_money,
              ),
            ],
          );
        }),

        WebSpacing.section(context),

        // Header Section
        PageHeader(
          title: WebTexts.subscriptionsTitle,
          searchHint: WebTexts.subscriptionsSearchHint,
          searchController: searchController,
          onSearchChanged: (value) {
            controller.searchQuery.value = value;
            if (value.isEmpty) {
              controller.loadSubscriptions();
            }
          },
          filterChips: FilterChipsRow(
            chips: [
              FilterChipItem(
                label: WebTexts.subscriptionsFilterAll,
                isSelected: controller.selectedFilter.value == 'all',
                onTap: () => controller.setFilter('all'),
              ),
              FilterChipItem(
                label: WebTexts.subscriptionsFilterActive,
                isSelected:
                    controller.selectedFilter.value ==
                        AppConstants.subscriptionStatusActive,
                onTap: () =>
                    controller.setFilter(AppConstants.subscriptionStatusActive),
              ),
              FilterChipItem(
                label: WebTexts.subscriptionsFilterCancelled,
                isSelected:
                    controller.selectedFilter.value ==
                        AppConstants.subscriptionStatusCancelled,
                onTap: () => controller
                    .setFilter(AppConstants.subscriptionStatusCancelled),
              ),
              FilterChipItem(
                label: WebTexts.subscriptionsFilterExpired,
                isSelected:
                    controller.selectedFilter.value ==
                        AppConstants.subscriptionStatusExpired,
                onTap: () =>
                    controller.setFilter(AppConstants.subscriptionStatusExpired),
              ),
            ],
          ),
        ),

        WebSpacing.section(context),

        // Subscriptions Table/List
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const LoadingState();
            }

            if (controller.subscriptions.isEmpty) {
              return EmptyState(
                icon: Icons.subscriptions_outlined,
                message: WebTexts.subscriptionsNoSubscriptionsFound,
              );
            }

            // Use DataTable for desktop, ListView for mobile
            if (WebResponsive.isDesktop(context)) {
              return SubscriptionTable(
                subscriptions: controller.subscriptions,
                onViewDetails: (subscription) =>
                    _showSubscriptionDetails(context, subscription),
                onCancel: (subscription) =>
                    _handleCancelSubscription(context, subscription),
                onReactivate: (subscription) =>
                    _handleReactivateSubscription(context, subscription),
              );
            } else {
              return SubscriptionList(
                subscriptions: controller.subscriptions,
                onViewDetails: (subscription) =>
                    _showSubscriptionDetails(context, subscription),
                onCancel: (subscription) =>
                    _handleCancelSubscription(context, subscription),
                onReactivate: (subscription) =>
                    _handleReactivateSubscription(context, subscription),
              );
            }
          }),
        ),
      ],
    );
  }

  void _showSubscriptionDetails(
      BuildContext context, SubscriptionModel subscription) {
    Get.dialog(SubscriptionDetailDialog(subscription: subscription));
  }

  void _handleCancelSubscription(
      BuildContext context, SubscriptionModel subscription) {
    SubscriptionActionDialogs.showCancelDialog(
      context,
      subscription,
      (reason) => controller.cancelSubscription(
        subscription.id,
        reason: reason,
      ),
    );
  }

  void _handleReactivateSubscription(
      BuildContext context, SubscriptionModel subscription) {
    SubscriptionActionDialogs.showReactivateDialog(
      context,
      subscription,
      () => controller.reactivateSubscription(subscription.id),
    );
  }
}
