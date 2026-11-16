import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/core/services/audio_service.dart';
import 'package:energy_blast/core/services/haptic_service.dart';
import 'package:energy_blast/l10n/app_localizations.dart';
import 'package:energy_blast/shared/widgets/auto_text.dart';
import 'package:energy_blast/features/game/presentation/pages/legal_page.dart';

class InfoDialog extends ConsumerWidget {
  const InfoDialog({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    void playClick() {
      ref.read(audioServiceProvider).play(AppSound.click);
      ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingL, horizontal: AppConstants.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 2),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 20, spreadRadius: 2)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoText.singleLine(
              l10n.infoTitle,
              style: const TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: AppConstants.paddingM),

            _buildMenuItem(
              icon: Icons.menu_book_rounded,
              title: l10n.howToPlay,
              onTap: () {
                playClick();
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => LegalPage(title: l10n.howToPlay, assetPath: 'assets/legal/how_to_play.yaml')
                ));
              },
            ),
            _buildMenuItem(
              icon: Icons.privacy_tip_rounded,
              title: l10n.privacyPolicy,
              onTap: () {
                playClick();
                _launchUrl('https://vladimirba.github.io/privacy.html');
              },
            ),
            _buildMenuItem(
              icon: Icons.gavel_rounded,
              title: l10n.termsOfService,
              onTap: () {
                playClick();
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => LegalPage(title: l10n.termsOfService, assetPath: 'assets/legal/terms_of_services.yaml')
                ));
              },
            ),
            _buildMenuItem(
              icon: Icons.code_rounded,
              title: l10n.licenses,
              onTap: () {
                playClick();
                showLicensePage(
                  context: context,
                  applicationName: l10n.appTitle,
                  applicationVersion: '0.1.0',
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.info_rounded,
              title: l10n.aboutGame,
              onTap: () {
                playClick();
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => LegalPage(title: l10n.aboutGame, assetPath: 'assets/legal/about_game.yaml')
                ));
              },
            ),

            const SizedBox(height: AppConstants.paddingM),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  playClick();
                  Navigator.pop(context);
                },
                child: AutoText.singleLine(
                  l10n.close,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      leading: Icon(icon, color: AppColors.primary, size: 28),
      title: AutoText.singleLine(
        title,
        alignment: Alignment.centerLeft,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary, size: 16),
      onTap: onTap,
    );
  }
}