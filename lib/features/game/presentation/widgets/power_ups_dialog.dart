import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/core/models/power_up_type.dart';
import 'package:energy_blast/features/game/application/game_controller.dart';
import 'package:energy_blast/core/services/rewarded_ad_manager.dart';
import 'package:energy_blast/l10n/app_localizations.dart';
import 'package:energy_blast/shared/widgets/auto_text.dart';

class PowerUpsDialog extends ConsumerWidget {
  const PowerUpsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final gameState = ref.watch(gameControllerProvider);
    final notifier = ref.read(gameControllerProvider.notifier);

    final messenger = ScaffoldMessenger.of(context);
    final adUnavailableMsg = l10n.adUnavailableBonus;
    final noMovesFoundMsg = l10n.noMovesFound;

    final bool isRescue = gameState.isOutOfMoves;
    const Duration applyDelay = Duration(milliseconds: 500);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 2),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoText.singleLine(
                isRescue ? l10n.rescueBonusesTitle : l10n.bonusesTitle,
                style: const TextStyle(color: AppColors.primary, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
              const SizedBox(height: AppConstants.paddingS),
              if (isRescue)
                AutoText.multiline(
                  l10n.selectBonusToSave,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              const SizedBox(height: AppConstants.paddingM),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildBonusCard(
                    context, ref, notifier, gameState, l10n,
                    type: PowerUpType.surprise,
                    title: l10n.bonusSurprise,
                    icon: Icons.help_outline,
                    color: AppColors.crystalAmber,
                    onUse: () {
                      notifier.startBonusProcessing();
                      Navigator.pop(context);
                      Future.delayed(applyDelay, () async {
                        await notifier.useSurprise();
                      });
                    },
                    onAd: () {
                      notifier.startBonusProcessing();
                      Navigator.pop(context);
                      bool earned = false;
                      RewardedAdManager.showAd(
                        onUserEarnedReward: () => earned = true,
                        onAdDismissed: () {
                          if (earned) {
                            Future.delayed(const Duration(milliseconds: 500), () async {
                              await notifier.onAdReward(PowerUpType.surprise);
                            });
                          } else {
                            notifier.cancelBonusProcessing();
                          }
                        },
                        onAdFailed: () {
                          Future.delayed(const Duration(milliseconds: 500), () async {
                            await notifier.onAdReward(PowerUpType.surprise);
                            messenger.showSnackBar(
                              SnackBar(content: Text(adUnavailableMsg)),
                            );
                          });
                        },
                      );
                    },
                  ),
                  _buildBonusCard(
                    context, ref, notifier, gameState, l10n,
                    type: PowerUpType.hammer,
                    title: l10n.bonusHammer,
                    icon: Icons.gavel,
                    color: AppColors.crystalRuby,
                    onUse: () {
                      notifier.startBonusProcessing();
                      Navigator.pop(context);
                      Future.delayed(applyDelay, () {
                        notifier.toggleHammerMode();
                      });
                    },
                    onAd: () {
                      notifier.startBonusProcessing();
                      Navigator.pop(context);
                      bool earned = false;
                      RewardedAdManager.showAd(
                        onUserEarnedReward: () => earned = true,
                        onAdDismissed: () {
                          if (earned) {
                            Future.delayed(const Duration(milliseconds: 500), () async {
                              await notifier.onAdReward(PowerUpType.hammer);
                            });
                          } else {
                            notifier.cancelBonusProcessing();
                          }
                        },
                        onAdFailed: () {
                          Future.delayed(const Duration(milliseconds: 500), () async {
                            await notifier.onAdReward(PowerUpType.hammer);
                            messenger.showSnackBar(
                              SnackBar(content: Text(adUnavailableMsg)),
                            );
                          });
                        },
                      );
                    },
                  ),
                  _buildBonusCard(
                    context, ref, notifier, gameState, l10n,
                    type: PowerUpType.shuffle,
                    title: l10n.bonusNewBlocks,
                    icon: Icons.refresh,
                    color: AppColors.crystalSapphire,
                    onUse: () {
                      notifier.startBonusProcessing();
                      Navigator.pop(context);
                      Future.delayed(applyDelay, () async {
                        await notifier.useNewBlocks();
                      });
                    },
                    onAd: () {
                      notifier.startBonusProcessing();
                      Navigator.pop(context);
                      bool earned = false;
                      RewardedAdManager.showAd(
                        onUserEarnedReward: () => earned = true,
                        onAdDismissed: () {
                          if (earned) {
                            Future.delayed(const Duration(milliseconds: 500), () async {
                              await notifier.onAdReward(PowerUpType.shuffle);
                            });
                          } else {
                            notifier.cancelBonusProcessing();
                          }
                        },
                        onAdFailed: () {
                          Future.delayed(const Duration(milliseconds: 500), () async {
                            await notifier.onAdReward(PowerUpType.shuffle);
                            messenger.showSnackBar(
                              SnackBar(content: Text(adUnavailableMsg)),
                            );
                          });
                        },
                      );
                    },
                  ),
                  _buildBonusCard(
                    context, ref, notifier, gameState, l10n,
                    type: PowerUpType.hint,
                    title: l10n.bonusHint,
                    icon: Icons.lightbulb_outline,
                    color: Colors.greenAccent,
                    onUse: () {
                      notifier.startBonusProcessing();
                      Navigator.pop(context);
                      Future.delayed(applyDelay, () async {
                        final bool found = await notifier.useHint();
                        if (!found) {
                          messenger.showSnackBar(
                            SnackBar(content: Text(noMovesFoundMsg)),
                          );
                          notifier.cancelBonusProcessing();
                        }
                      });
                    },
                    onAd: () {
                      notifier.startBonusProcessing();
                      Navigator.pop(context);
                      bool earned = false;
                      RewardedAdManager.showAd(
                        onUserEarnedReward: () => earned = true,
                        onAdDismissed: () {
                          if (earned) {
                            Future.delayed(const Duration(milliseconds: 500), () async {
                              await notifier.onAdReward(PowerUpType.hint);
                            });
                          } else {
                            notifier.cancelBonusProcessing();
                          }
                        },
                        onAdFailed: () {
                          Future.delayed(const Duration(milliseconds: 500), () async {
                            await notifier.onAdReward(PowerUpType.hint);
                            messenger.showSnackBar(
                              SnackBar(content: Text(adUnavailableMsg)),
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
                  child: AutoText.singleLine(
                    l10n.close,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBonusCard(
      BuildContext context, WidgetRef ref, GameController notifier, GameState state, AppLocalizations l10n, {
        required PowerUpType type,
        required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onUse,
        required VoidCallback onAd,
      }) {
    int freeCount = 0;
    if (type == PowerUpType.surprise) {
      freeCount = state.freeSurprises;
    } else if (type == PowerUpType.hammer) {
      freeCount = state.freeHammers;
    } else if (type == PowerUpType.shuffle) {
      freeCount = state.freeShuffles;
    } else if (type == PowerUpType.hint) {
      freeCount = state.freeHints;
    }

    bool canWatchAd = false;

    // UPDATED LOGIC: Allow normal ads in rescue mode as a fallback
    if (type == PowerUpType.surprise) {
      canWatchAd = (state.isOutOfMoves && state.rescueSurprises == 0) || (state.adSurprises < 2);
    } else if (type == PowerUpType.hammer) {
      canWatchAd = (state.isOutOfMoves && state.rescueHammers == 0) || (state.adHammers < 2);
    } else if (type == PowerUpType.shuffle) {
      canWatchAd = (state.isOutOfMoves && state.rescueShuffles == 0) || (state.adShuffles < 2);
    } else if (type == PowerUpType.hint) {
      bool hasValidMove = state.pieces.any((p) => state.board.canPlaceAnywhere(p));
      canWatchAd = hasValidMove && (state.adHints < 2); // Hint ads are just normal ads
    }

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
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color.withValues(alpha: 0.5)),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 28,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isHintDisabled ? AppColors.textSecondary.withValues(alpha: 0.5) : Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            height: 32,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: isHintDisabled && freeCount > 0
                  ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                onPressed: null,
                child: Text(l10n.useBonus(freeCount), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              )
                  : isHintDisabled
                  ? Text(
                l10n.limitLabel,
                style: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : freeCount > 0
                  ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color, foregroundColor: Colors.black,
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                onPressed: onUse,
                child: Text(l10n.useBonus(freeCount), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              )
                  : canWatchAd
                  ? ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, foregroundColor: Colors.black,
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
                onPressed: onAd,
                icon: const Icon(Icons.play_arrow, size: 14),
                label: Text(l10n.adButton, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              )
                  : Text(
                l10n.limitLabel,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}