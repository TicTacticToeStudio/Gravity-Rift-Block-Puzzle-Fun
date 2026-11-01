import 'package:flutter/material.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/l10n/app_localizations.dart';

class MoreGamesPage extends StatelessWidget {
  const MoreGamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.myGamesTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        children: [
          // Placeholder for your Tic Tac Toe game
          _buildGameCard(
            title: "Tic Tac Toe: Fun & Strategy",
            subtitle: "Classic game with a modern neon twist.",
            icon: Icons.grid_3x3,
            color: Colors.blueAccent,
            onTap: () {
              // Here you would use url_launcher to open the store link
              // await launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.studio3t.tictactictoe'));
            },
          ),

          const SizedBox(height: AppConstants.paddingM),

          // Placeholder for future games
          _buildGameCard(
            title: "Coming Soon",
            subtitle: "Stay tuned for our next puzzle!",
            icon: Icons.auto_awesome,
            color: AppColors.secondary,
            onTap: () {},
            isDisabled: true,
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingS),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
