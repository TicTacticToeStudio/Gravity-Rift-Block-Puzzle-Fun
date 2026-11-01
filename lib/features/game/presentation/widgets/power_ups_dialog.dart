import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/features/game/application/game_controller.dart';
import 'package:energy_blast/core/services/power_up_service.dart';
import 'package:energy_blast/core/services/rewarded_ad_manager.dart';

class PowerUpsDialog extends ConsumerWidget {
  const PowerUpsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final notifier = ref.read(gameControllerProvider.notifier);

    // Check if we are in the rescue phase
    final bool isRescue = gameState.isOutOfMoves;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isRescue ? 'RESCUE BONUSES' : 'BONUSES',
              style: const TextStyle(color: AppColors.primary, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: AppConstants.paddingS),
            if (isRescue)
              const Text(
                'Select a bonus to save your game',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            const SizedBox(height: AppConstants.paddingM),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _buildBonusCard(
                  context, ref, notifier, gameState,
                  type: PowerUpType.surprise,
                  title: 'Surprise',
                  icon: Icons.help_outline,
                  color: AppColors.crystalAmber,
                  onUse: () { notifier.useSurprise(); Navigator.pop(context); },
                  onAd: () {
                    Navigator.pop(context);
                    RewardedAdManager.showAd(
                      onUserEarnedReward: () => notifier.onAdReward(PowerUpType.surprise),
                      onAdDismissed: () {},
                      onAdFailed: () {
                        notifier.onAdReward(PowerUpType.surprise);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ad unavailable. Here is your bonus!')),
                        );
                      },
                    );
                  },
                ),
                _buildBonusCard(
                  context, ref, notifier, gameState,
                  type: PowerUpType.hammer,
                  title: 'Hammer',
                  icon: Icons.gavel,
                  color: AppColors.crystalRuby,
                  onUse: () { notifier.toggleHammerMode(); Navigator.pop(context); },
                  onAd: () {
                    Navigator.pop(context);
                    RewardedAdManager.showAd(
                      onUserEarnedReward: () => notifier.onAdReward(PowerUpType.hammer),
                      onAdDismissed: () {},
                      onAdFailed: () {
                        notifier.onAdReward(PowerUpType.hammer);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ad unavailable. Here is your bonus!')),
                        );
                      },
                    );
                  },
                ),
                _buildBonusCard(
                  context, ref, notifier, gameState,
                  type: PowerUpType.shuffle,
                  title: 'New Blocks',
                  icon: Icons.refresh,
                  color: AppColors.crystalSapphire,
                  onUse: () { notifier.useNewBlocks(); Navigator.pop(context); },
                  onAd: () {
                    Navigator.pop(context);
                    RewardedAdManager.showAd(
                      onUserEarnedReward: () => notifier.onAdReward(PowerUpType.shuffle),
                      onAdDismissed: () {},
                      onAdFailed: () {
                        notifier.onAdReward(PowerUpType.shuffle);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ad unavailable. Here is your bonus!')),
                        );
                      },
                    );
                  },
                ),
                _buildBonusCard(
                  context, ref, notifier, gameState,
                  type: PowerUpType.hint,
                  title: 'Hint',
                  icon: Icons.lightbulb_outline,
                  color: Colors.greenAccent,
                  onUse: () {
                    bool found = notifier.useHint();
                    Navigator.pop(context);
                    if (!found) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No moves found! Use another bonus.')),
                      );
                    }
                  },
                  onAd: () {
                    Navigator.pop(context);
                    RewardedAdManager.showAd(
                      onUserEarnedReward: () => notifier.onAdReward(PowerUpType.hint),
                      onAdDismissed: () {},
                      onAdFailed: () {
                        notifier.onAdReward(PowerUpType.hint);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ad unavailable. Here is your bonus!')),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingM),
            // Close button for manual dismissal (if not in rescue)
            if (!isRescue)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CLOSE', style: TextStyle(color: AppColors.textSecondary)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBonusCard(
      BuildContext context, WidgetRef ref, GameController notifier, GameState state, {
        required PowerUpType type,
        required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onUse,
        required VoidCallback onAd,
      }) {
    // 1. Determine the number of free items
    int freeCount = 0;
    if (type == PowerUpType.surprise) freeCount = state.freeSurprises;
    if (type == PowerUpType.hammer) freeCount = state.freeHammers;
    if (type == PowerUpType.shuffle) freeCount = state.freeShuffles;
    if (type == PowerUpType.hint) freeCount = state.freeHints;

    // 2. Determine if an ad can be watched
    bool canWatchAd = false;
    if (state.isOutOfMoves) {
      // In rescue mode: Max 1 ad per bonus
      if (type == PowerUpType.surprise && state.rescueSurprises == 0) canWatchAd = true;
      if (type == PowerUpType.hammer && state.rescueHammers == 0) canWatchAd = true;
      if (type == PowerUpType.shuffle && state.rescueShuffles == 0) canWatchAd = true;
      if (type == PowerUpType.hint && state.rescueHints == 0) canWatchAd = true;
    } else {
      // In game mode: Max 2 ads per bonus
      if (type == PowerUpType.surprise && state.adSurprises < 2) canWatchAd = true;
      if (type == PowerUpType.hammer && state.adHammers < 2) canWatchAd = true;
      if (type == PowerUpType.shuffle && state.adShuffles < 2) canWatchAd = true;
      if (type == PowerUpType.hint && state.adHints < 2) canWatchAd = true;
    }

    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.5)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2),
          const SizedBox(height: 8),

          if (freeCount > 0)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color, foregroundColor: Colors.black,
                minimumSize: const Size(0, 32),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              onPressed: onUse,
              child: Text('USE ($freeCount)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            )
          else if (canWatchAd)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, foregroundColor: Colors.black,
                minimumSize: const Size(0, 32),
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),
              onPressed: onAd,
              icon: const Icon(Icons.play_arrow, size: 14),
              label: const Text('AD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            )
          else
            const Text('LIMIT', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}