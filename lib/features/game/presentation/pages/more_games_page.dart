import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/core/services/audio_service.dart';
import 'package:energy_blast/core/services/haptic_service.dart';
import 'package:energy_blast/l10n/app_localizations.dart';

class MoreGamesPage extends ConsumerWidget {
  const MoreGamesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.myGamesTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            ref.read(audioServiceProvider).play(AppSound.click);
            ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        children: [
          // Game 1: Hex Tic Tac Toe
          _buildGameCard(
            title: l10n.hexGameTitle,
            subtitle: l10n.hexGameDesc,
            imagePath: "assets/images/HEX_Icon.png",
            color: Colors.purpleAccent,
            onTap: () {
              ref.read(audioServiceProvider).play(AppSound.click);
              ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
              _launchStoreUrl('https://play.google.com/store/apps/details?id=com.studio3t.hextactictoe');
            },
          ),

          const SizedBox(height: AppConstants.paddingM),

          // Game 2: Tic Tac Toe
          _buildGameCard(
            title: l10n.tttGameTitle,
            subtitle: l10n.tttGameDesc,
            imagePath: "assets/images/TTT_icon_final.png",
            color: Colors.blueAccent,
            onTap: () {
              ref.read(audioServiceProvider).play(AppSound.click);
              ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
              _launchStoreUrl('https://play.google.com/store/apps/details?id=com.studio3t.tictactictoe');
            },
          ),

          const SizedBox(height: AppConstants.paddingM),

          // Game 3: Coming Soon Placeholder
          _buildGameCard(
            title: l10n.comingSoonTitle,
            subtitle: l10n.comingSoonDesc,
            icon: Icons.auto_awesome,
            color: AppColors.secondary,
            onTap: () {}, // No sound/action for disabled card
            isDisabled: true,
          ),
        ],
      ),
    );
  }

  // Helper method to open the Play Store link safely
  Future<void> _launchStoreUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildGameCard({
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    String? imagePath,
    IconData? icon,
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(color: color.withOpacity(isDisabled ? 0.1 : 0.5), width: 2),
          boxShadow: isDisabled ? [] : [
            BoxShadow(color: color.withOpacity(0.2), blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP ROW: Icon + Title + Chevron
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Render Image if provided, otherwise render Icon
                if (imagePath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                    child: Image.asset(
                      imagePath,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 56,
                          height: 56,
                          color: color.withOpacity(0.2),
                          child: Icon(icon ?? Icons.gamepad, color: color, size: 28),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(AppConstants.paddingS),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon ?? Icons.gamepad, color: color, size: 28),
                  ),

                const SizedBox(width: 12),

                // Title text
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                ),

                // Arrow icon for active games
                if (!isDisabled)
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // BOTTOM SECTION: Full Width Subtitle (max 3 lines to fit text)
            Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}