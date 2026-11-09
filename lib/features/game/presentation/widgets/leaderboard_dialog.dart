import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/core/services/high_score_service.dart';
import 'package:energy_blast/l10n/app_localizations.dart';

class LeaderboardDialog extends ConsumerWidget {
  const LeaderboardDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingL),
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
            const Icon(Icons.emoji_events, color: AppColors.crystalAmber, size: 48),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              l10n.topScores,
              style: const TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: AppConstants.paddingM),

            // Flexible ensures the list shrinks and keeps the CLOSE button visible
            Flexible(
              child: FutureBuilder<List<ScoreRecord>>(
                future: HighScoreService.getScores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  }

                  final scores = snapshot.data ?? [];

                  if (scores.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingL),
                      child: Text(
                        l10n.noRecordsYet,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: scores.length,
                    itemBuilder: (context, index) {
                      final record = scores[index];
                      Color rankColor = AppColors.textPrimary;
                      if (index == 0) {
                        rankColor = Colors.amberAccent;
                      } else if (index == 1) {
                        rankColor = Colors.grey;
                      } else if (index == 2) {
                        rankColor = Colors.brown;
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: AppConstants.paddingS),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: rankColor.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}.',
                              style: TextStyle(color: rankColor, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 3,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${record.score}',
                                  style: const TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                // Now using relative dates from the service
                                HighScoreService.formatRelativeDate(record.date, l10n),
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: AppConstants.paddingM),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.close, style: const TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}