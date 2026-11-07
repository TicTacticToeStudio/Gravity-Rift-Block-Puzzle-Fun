import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/core/models/power_up_type.dart';
import 'package:energy_blast/features/game/application/game_controller.dart';
import 'package:energy_blast/core/services/rewarded_ad_manager.dart';

class PowerUpsDialog extends ConsumerWidget {
  const PowerUpsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final notifier = ref.read(gameControllerProvider.notifier);

    final bool isRescue = gameState.isOutOfMoves;

    // A short delay after Navigator.pop() gives the dialog time to finish its
    // exit animation before the bonus starts applying. Without it, the bonus
    // animation overlays the closing dialog and the result looks messy.
    const Duration applyDelay = Duration(milliseconds: 500);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
        ),
        // Wrapped in SingleChildScrollView to prevent RenderFlex overflow on small screens
        child: SingleChildScrollView(
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
                    onUse: () {
                      Navigator.pop(context);
                      Future.delayed(applyDelay, () {
                        notifier.useSurprise();
                      });
                    },
                    onAd: () {
                      Navigator.pop(context);
                      bool earned = false;
                      RewardedAdManager.showAd(
                        onUserEarnedReward: () => earned = true,
                        onAdDismissed: () {
                          if (earned) {
                            Future.delayed(const Duration(milliseconds: 500), () {
                              notifier.onAdReward(PowerUpType.surprise);
                            });
                          }
                        },
                        onAdFailed: () {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            notifier.onAdReward(PowerUpType.surprise);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ad unavailable. Here is your bonus!')),
                            );
                          });
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
                    onUse: () {
                      Navigator.pop(context);
                      Future.delayed(applyDelay, () {
                        notifier.toggleHammerMode();
                      });
                    },
                    onAd: () {
                      Navigator.pop(context);
                      bool earned = false;
                      RewardedAdManager.showAd(
                        onUserEarnedReward: () => earned = true,
                        onAdDismissed: () {
                          if (earned) {
                            Future.delayed(const Duration(milliseconds: 500), () {
                              notifier.onAdReward(PowerUpType.hammer);
                            });
                          }
                        },
                        onAdFailed: () {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            notifier.onAdReward(PowerUpType.hammer);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ad unavailable. Here is your bonus!')),
                            );
                          });
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
                    onUse: () {
                      Navigator.pop(context);
                      Future.delayed(applyDelay, () {
                        notifier.useNewBlocks();
                      });
                    },
                    onAd: () {
                      Navigator.pop(context);
                      bool earned = false;
                      RewardedAdManager.showAd(
                        onUserEarnedReward: () => earned = true,
                        onAdDismissed: () {
                          if (earned) {
                            Future.delayed(const Duration(milliseconds: 500), () {
                              notifier.onAdReward(PowerUpType.shuffle);
                            });
                          }
                        },
                        onAdFailed: () {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            notifier.onAdReward(PowerUpType.shuffle);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ad unavailable. Here is your bonus!')),
                            );
                          });
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
                      Navigator.pop(context);
                      Future.delayed(applyDelay, () {
                        final bool found = notifier.useHint();
                        // Guard against the dialog's context being unmounted
                        // during the delay before showing feedback.
                        if (!found && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No moves found! Use another bonus.')),
                          );
                        }
                      });
                    },
                    onAd: () {
                      Navigator.pop(context);
                      bool earned = false;
                      RewardedAdManager.showAd(
                        onUserEarnedReward: () => earned = true,
                        onAdDismissed: () {
                          if (earned) {
                            Future.delayed(const Duration(milliseconds: 500), () {
                              notifier.onAdReward(PowerUpType.hint);
                            });
                          }
                        },
                        onAdFailed: () {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            notifier.onAdReward(PowerUpType.hint);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ad unavailable. Here is your bonus!')),
                            );
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingM),
              if (!isRescue)
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CLOSE', style: TextStyle(color: AppColors.textSecondary)),
                ),
            ],
          ),
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
    int freeCount = 0;
    if (type == PowerUpType.surprise) freeCount = state.freeSurprises;
    if (type == PowerUpType.hammer) freeCount = state.freeHammers;
    if (type == PowerUpType.shuffle) freeCount = state.freeShuffles;
    if (type == PowerUpType.hint) freeCount = state.freeHints;

    bool canWatchAd = false;

    if (type == PowerUpType.surprise) {
      canWatchAd = state.isOutOfMoves ? state.rescueSurprises == 0 : state.adSurprises < 2;
    } else if (type == PowerUpType.hammer) {
      canWatchAd = state.isOutOfMoves ? state.rescueHammers == 0 : state.adHammers < 2;
    } else if (type == PowerUpType.shuffle) {
      canWatchAd = state.isOutOfMoves ? state.rescueShuffles == 0 : state.adShuffles < 2;
    } else if (type == PowerUpType.hint) {
      // Real-time scan to check if ANY piece fits on the board.
      bool hasValidMove = state.pieces.any((p) => state.board.canPlaceAnywhere(p));
      canWatchAd = hasValidMove && state.adHints < 2;
    }

    // In a deadlock (rescue mode) no valid move exists on the board,
    // so a hint cannot produce a suggestion. Show the card dimmed with a
    // disabled button instead of letting the player tap into a dead end.
    final bool isHintDisabled = state.isOutOfMoves && type == PowerUpType.hint;

    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Opacity(
            opacity: isHintDisabled ? 0.35 : 1.0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.5)),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: isHintDisabled ? AppColors.textSecondary.withOpacity(0.5) : Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(height: 8),

          if (isHintDisabled && freeCount > 0)
          // Disabled USE button: Material renders it greyed out automatically.
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 32),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              onPressed: null,
              child: Text('USE ($freeCount)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            )
          else if (isHintDisabled)
            Text(
              'LIMIT',
              style: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.5),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            )
          else if (freeCount > 0)
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