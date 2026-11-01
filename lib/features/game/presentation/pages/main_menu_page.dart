import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/l10n/app_localizations.dart';
import 'package:energy_blast/shared/widgets/cosmic_background.dart';
import 'package:energy_blast/core/providers/locale_provider.dart';
import 'package:energy_blast/core/services/save_game_service.dart';
import 'package:energy_blast/features/game/application/game_controller.dart';
import 'package:energy_blast/features/game/presentation/widgets/leaderboard_dialog.dart';
import 'game_page.dart';
import 'more_games_page.dart';

// Provider to check if a saved game exists
final hasSaveProvider = FutureProvider.autoDispose<bool>((ref) async {
  return await SaveGameService.hasSavedGame();
});

class MainMenuPage extends ConsumerWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeProvider);
    final hasSaveAsync = ref.watch(hasSaveProvider);

    // Split the title into main and sub-title for better visual hierarchy
    final titleParts = l10n.appTitle.split(':');
    final mainTitle = titleParts[0].toUpperCase();
    final subTitle = titleParts.length > 1 ? titleParts[1].trim().toUpperCase() : '';

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. TOP BAR (Info, Leaderboard, Language)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM, vertical: AppConstants.paddingS),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Info Button
                    IconButton(
                      icon: const Icon(Icons.info_outline, color: Colors.white, size: 32),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Info menu coming soon')),
                        );
                      },
                    ),

                    Row(
                      children: [
                        // Leaderboard Button
                        IconButton(
                          icon: const Icon(Icons.emoji_events, color: AppColors.crystalAmber, size: 32),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => const LeaderboardDialog(),
                            );
                          },
                        ),
                        const SizedBox(width: 8),

                        // Language Selector Button
                        GestureDetector(
                          onTap: () => _showLanguageDialog(context, ref),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  currentLocale.languageCode.toUpperCase(),
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_drop_down, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // 2. MASSIVE NEON TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // MAIN TITLE: SPACECORE
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Massive Glow
                          Text(
                            mainTitle,
                            style: TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4.0,
                              color: Colors.transparent,
                              shadows: [
                                Shadow(color: AppColors.primary.withOpacity(0.8), blurRadius: 40),
                                Shadow(color: AppColors.secondary.withOpacity(0.6), blurRadius: 20),
                              ],
                            ),
                          ),
                          // Thick Dark Outline for contrast against stars
                          Text(
                            mainTitle,
                            style: TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 8
                                ..color = const Color(0xFF0A0815), // Very dark cosmic background color
                            ),
                          ),
                          // Gradient Fill
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.primary, // Cyan
                                  Colors.white,
                                  AppColors.secondary, // Pink
                                ],
                                stops: [0.1, 0.5, 0.9],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              mainTitle,
                              style: const TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 4.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // SUBTITLE: BLOCK PUZZLE & FUN (Increased size)
                      if (subTitle.isNotEmpty) ...[
                        const SizedBox(height: 8), // Slightly more space
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              subTitle,
                              style: TextStyle(
                                fontSize: 28, // Increased from 20
                                fontWeight: FontWeight.bold,
                                letterSpacing: 6.0, // Slightly tighter spacing to fit the bigger font
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 5 // Thicker outline
                                  ..color = const Color(0xFF0A0815),
                              ),
                            ),
                            Text(
                              subTitle,
                              style: const TextStyle(
                                fontSize: 28, // Increased from 20
                                fontWeight: FontWeight.bold,
                                letterSpacing: 6.0,
                                color: AppColors.primary,
                                shadows: [
                                  Shadow(color: AppColors.primary, blurRadius: 15), // Stronger glow
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 3. MENU PANEL (Glassmorphism)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingL),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(AppConstants.radiusL),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConstants.radiusL),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.paddingM),
                        child: hasSaveAsync.when(
                          data: (hasSave) {
                            if (hasSave) {
                              return Column(
                                children: [
                                  // Continue Game Button
                                  _buildMenuButton(
                                    title: l10n.continueGame,
                                    subtitle: "Resume your game",
                                    icon: Icons.play_arrow,
                                    color: AppColors.primary,
                                    onTap: () async {
                                      final json = await SaveGameService.loadGame();
                                      if (json != null && context.mounted) {
                                        final savedState = GameState.fromJson(json);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => GamePage(savedState: savedState)),
                                        ).then((_) => ref.invalidate(hasSaveProvider));
                                      }
                                    },
                                  ),
                                  const SizedBox(height: AppConstants.paddingM),
                                  // New Game Button
                                  _buildMenuButton(
                                    title: l10n.newGame,
                                    subtitle: l10n.classicModeSub,
                                    icon: Icons.refresh,
                                    color: AppColors.secondary,
                                    onTap: () {
                                      SaveGameService.clearSave();
                                      ref.invalidate(hasSaveProvider);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => const GamePage())
                                      ).then((_) => ref.invalidate(hasSaveProvider));
                                    },
                                  ),
                                ],
                              );
                            } else {
                              // Standard Classic Mode Button
                              return _buildMenuButton(
                                title: l10n.classicMode,
                                subtitle: l10n.classicModeSub,
                                icon: Icons.view_quilt,
                                color: AppColors.primary,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const GamePage())
                                  ).then((_) => ref.invalidate(hasSaveProvider));
                                },
                              );
                            }
                          },
                          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                          error: (_, __) => _buildMenuButton(
                            title: l10n.classicMode,
                            subtitle: l10n.classicModeSub,
                            icon: Icons.view_quilt,
                            color: AppColors.primary,
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GamePage())),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // 4. FOOTER (Sound & More Games)
              Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.paddingM),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildFooterButton(
                      icon: Icons.volume_up,
                      label: l10n.sound,
                      onPressed: () {},
                    ),
                    const SizedBox(width: AppConstants.paddingM),
                    _buildFooterButton(
                      icon: Icons.sports_esports,
                      label: l10n.moreGames,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MoreGamesPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.read(localeProvider);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
          ),
          title: const Text(
            'Language / Язык',
            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageTile(context, ref, 'English', const Locale('en'), currentLocale),
              _buildLanguageTile(context, ref, 'Русский', const Locale('ru'), currentLocale),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile(BuildContext context, WidgetRef ref, String label, Locale locale, Locale currentLocale) {
    final isSelected = locale.languageCode == currentLocale.languageCode;

    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () {
        ref.read(localeProvider.notifier).changeLocale(locale);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildMenuButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.2), blurRadius: 10, spreadRadius: 1)
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
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

  Widget _buildFooterButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: AppColors.primary, size: 18),
      label: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        backgroundColor: AppColors.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
      ),
    );
  }
}