import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/core/providers/settings_provider.dart';
import 'package:energy_blast/core/services/audio_service.dart';
import 'package:energy_blast/core/services/haptic_service.dart';
import 'package:energy_blast/l10n/app_localizations.dart';
import 'package:energy_blast/shared/widgets/auto_text.dart';
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

  // Helper to play click sound and haptic
  void _playClick(WidgetRef ref) {
    ref.read(audioServiceProvider).play(AppSound.click);
    ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeProvider);
    final settings = ref.watch(settingsProvider);
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
                        _playClick(ref);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.infoComingSoon)),
                        );
                      },
                    ),

                    Row(
                      children: [
                        // Leaderboard Button
                        IconButton(
                          icon: const Icon(Icons.emoji_events, color: AppColors.crystalAmber, size: 32),
                          onPressed: () {
                            _playClick(ref);
                            showDialog(
                              context: context,
                              builder: (_) => const LeaderboardDialog(),
                            );
                          },
                        ),
                        const SizedBox(width: 8),

                        // Language Selector Button
                        GestureDetector(
                          onTap: () {
                            _playClick(ref);
                            _showLanguageDialog(context, ref);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
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
                      // MAIN TITLE
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
                                Shadow(color: AppColors.primary.withValues(alpha: 0.8), blurRadius: 40),
                                Shadow(color: AppColors.secondary.withValues(alpha: 0.6), blurRadius: 20),
                              ],
                            ),
                          ),
                          // Thick Dark Outline
                          Text(
                            mainTitle,
                            style: TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 8
                                ..color = const Color(0xFF0A0815),
                            ),
                          ),
                          // Gradient Fill
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.primary,
                                  Colors.white,
                                  AppColors.secondary,
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

                      // SUBTITLE
                      if (subTitle.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              subTitle,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 6.0,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 5
                                  ..color = const Color(0xFF0A0815),
                              ),
                            ),
                            Text(
                              subTitle,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 6.0,
                                color: AppColors.primary,
                                shadows: [
                                  Shadow(color: AppColors.primary, blurRadius: 15),
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

              const Spacer(flex: 1),

              // 3. MENU PANEL (Glassmorphism)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingL),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(AppConstants.radiusL),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
                                    subtitle: l10n.resumeYourGame,
                                    icon: Icons.play_arrow,
                                    color: AppColors.primary,
                                    showBoardBackground: false,
                                    onTap: () async {
                                      _playClick(ref);
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
                                    subtitle: l10n.startFresh,
                                    icon: Icons.refresh,
                                    color: AppColors.secondary,
                                    showBoardBackground: false,
                                    onTap: () {
                                      _playClick(ref);
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
                              // Standard Play Button (with Board Background)
                              return _buildMenuButton(
                                title: l10n.playNow.toUpperCase(),
                                subtitle: l10n.classicModeSub,
                                icon: Icons.play_circle_fill,
                                color: AppColors.primary,
                                showBoardBackground: true,
                                onTap: () {
                                  _playClick(ref);
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
                            title: l10n.playNow.toUpperCase(),
                            subtitle: l10n.classicModeSub,
                            icon: Icons.play_circle_fill,
                            color: AppColors.primary,
                            showBoardBackground: true,
                            onTap: () {
                              _playClick(ref);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const GamePage()));
                            },
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
                    Flexible(
                      child: _buildFooterButton(
                        icon: settings.isSoundOn ? Icons.volume_up : Icons.volume_off,
                        label: l10n.sound,
                        onPressed: () {
                          ref.read(settingsProvider.notifier).toggleSound();
                          if (!settings.isSoundOn) {
                            _playClick(ref);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: AppConstants.paddingM),
                    Flexible(
                      child: _buildFooterButton(
                        icon: Icons.sports_esports,
                        label: l10n.moreGames,
                        onPressed: () {
                          _playClick(ref);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const MoreGamesPage()),
                          );
                        },
                      ),
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
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.read(localeProvider);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          title: AutoText.singleLine(
            l10n.languageTitle,
            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
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
      title: AutoText.singleLine(
        label,
        alignment: Alignment.centerLeft,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () {
        _playClick(ref);
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
    bool showBoardBackground = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        child: Stack(
          children: [
            // Draw the board background only if requested
            if (showBoardBackground)
              Positioned.fill(
                child: CustomPaint(
                  painter: _PlaqueBoardPainter(),
                ),
              ),

            // Foreground Content
            Container(
              // Generous vertical padding for a taller button
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: showBoardBackground ? Colors.black.withValues(alpha: 0.3) : color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                border: Border.all(color: color.withValues(alpha: 0.7), width: 2),
                boxShadow: [
                  BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 15, spreadRadius: 2)
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title: single-line, scales down if the translation
                        // doesn't fit (French/German tend to be longer).
                        AutoText.singleLine(
                          title,
                          alignment: Alignment.centerLeft,
                          style: TextStyle(
                            color: color,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Subtitle: multiline, wraps naturally, button grows
                        // in height to accommodate longer descriptions.
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: showBoardBackground ? Colors.white.withValues(alpha: 0.9) : AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                            shadows: showBoardBackground ? [const Shadow(color: Colors.black, blurRadius: 4)] : [],
                          ),
                        ),
                      ],
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
      label: AutoText.singleLine(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
      ),
    );
  }
}

// Custom painter to draw a mini game board *inside* the button
class _PlaqueBoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.height / 3;

    final emptyCellPaint = Paint()..color = AppColors.boardEmptyCell.withValues(alpha: 0.4);

    // Draw empty grid
    for (double y = 0; y < size.height; y += cellSize) {
      for (double x = 0; x < size.width; x += cellSize) {
        final rect = Rect.fromLTWH(x + 2, y + 2, cellSize - 4, cellSize - 4);
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(4)),
          emptyCellPaint,
        );
      }
    }

    // Draw some bright crystals to simulate a game in progress
    final colors = [
      AppColors.crystalRuby,
      AppColors.crystalSapphire,
      AppColors.crystalEmerald,
      AppColors.crystalAmber,
    ];

    final blockPositions = [
      const Offset(0, 0), const Offset(1, 0), const Offset(2, 0),
      const Offset(3, 1), const Offset(4, 1),
      const Offset(6, 0), const Offset(7, 0), const Offset(8, 0),
      const Offset(10, 1), const Offset(10, 2), const Offset(11, 2),
      const Offset(13, 0), const Offset(14, 0), const Offset(14, 1),
    ];

    for (int i = 0; i < blockPositions.length; i++) {
      final pos = blockPositions[i];
      final x = pos.dx * cellSize;
      final y = pos.dy * cellSize;

      if (x >= size.width) continue;

      final rect = Rect.fromLTWH(x + 2, y + 2, cellSize - 4, cellSize - 4);
      final crystalColor = colors[i % colors.length].withValues(alpha: 0.6);

      final glowPaint = Paint()
        ..color = crystalColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      final crystalPaint = Paint()..color = crystalColor;

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        glowPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        crystalPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}