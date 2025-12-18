import 'package:amorra/core/utils/app_images/app_images.dart';
import 'package:amorra/presentation/widgets/common/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// App Image Avatar Widget
/// Reusable avatar widget that can display:
/// - User profile image (if available) or age-based avatar
/// - AI chatbot logo
class AppImageAvatar extends StatelessWidget {
  final int? age;
  final double? size;
  final String? profileImageUrl;
  final bool
  showProfileImage; // If true, show profile image; if false, show avatar
  final bool isAI; // If true, show AI chatbot logo

  const AppImageAvatar({
    super.key,
    this.age,
    this.size,
    this.profileImageUrl,
    this.showProfileImage = false,
    this.isAI = false,
  });

  /// Get avatar image based on age (for user avatars)
  String _getAvatarImage() {
    if (age == null) {
      return AppImages.avatarAge40; // Default
    }
    if (age! >= 70) {
      return AppImages.avatarAge70;
    } else if (age! >= 60) {
      return AppImages.avatarAge60;
    } else {
      return AppImages.avatarAge40;
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? AppResponsive.iconSize(context, factor: 2);

    // If AI, show chatbot logo
    if (isAI) {
      return Container(
        width: avatarSize,
        height: avatarSize,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: Image.asset(
            AppImages.chatbotLogo,
            width: avatarSize,
            height: avatarSize,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // For user: show profile image if available, otherwise show age-based avatar
    final bool shouldShowProfileImage =
        showProfileImage &&
        profileImageUrl != null &&
        profileImageUrl!.isNotEmpty;

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: shouldShowProfileImage
            ? CachedNetworkImage(
                imageUrl: profileImageUrl!,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: avatarSize,
                  height: avatarSize,
                  color: Colors.grey[200],
                  child: Center(
                    child: AppLoadingIndicator(
                      size: AppResponsive.iconSize(context, factor: 2),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  _getAvatarImage(),
                  width: avatarSize,
                  height: avatarSize,
                  fit: BoxFit.cover,
                ),
              )
            : Image.asset(
                _getAvatarImage(),
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
