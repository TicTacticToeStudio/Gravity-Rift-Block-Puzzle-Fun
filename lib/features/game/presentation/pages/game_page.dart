import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/core/providers/settings_provider.dart';
import 'package:energy_blast/core/services/audio_service.dart';
import 'package:energy_blast/core/services/haptic_service.dart';
import 'package:energy_blast/core/models/power_up_type.dart';
import 'package:energy_blast/l10n/app_localizations.dart';
import 'package:energy_blast/features/game/application/game_controller.dart';
import 'package:energy_blast/features/game/domain/models/piece.dart';
import 'package:energy_blast/features/game/presentation/widgets/board/board_widget.dart';
import 'package:energy_blast/features/game/presentation/widgets/piece_tray_widget.dart';
import 'package:energy_blast/features/game/presentation/widgets/power_ups_dialog.dart';
import 'package:energy_blast/shared/widgets/ad_banner_widget.dart';
import 'package:energy_blast/core/services/rewarded_ad_manager.dart';

class GamePage extends ConsumerStatefulWidget {
  final GameState? savedState;
  const GamePage({super.key, this.savedState});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> with WidgetsBindingObserver {
  final GlobalKey _boardKey = GlobalKey();

  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Pre-initialize the audio service so the first sound plays without delay.
    ref.read(audioServiceProvider);

    if (widget.savedState != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(gameControllerProvider.notifier).resumeGame(widget.savedState!);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      ref.read(gameControllerProvider.notifier).saveCurrentGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameControllerProvider);
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context);

    final bool isHammerBlocking = gameState.isHammerActive;

    final bool hasAnyFreeBonuses = gameState.freeSurprises > 0 || gameState.freeHammers > 0 || gameState.freeShuffles > 0 || gameState.freeHints > 0;
    final bool hasAnyAdsLeft = gameState.adSurprises < 2 || gameState.adHammers < 2 || gameState.adShuffles < 2 || gameState.adHints < 2;
    final bool canUseBonuses = (hasAnyFreeBonuses || hasAnyAdsLeft || gameState.isOutOfMoves) && !isHammerBlocking;

    bool hasFreeUndos = gameState.freeUndos > 0;
    bool canWatchGameAd = !gameState.isOutOfMoves && gameState.adUndos < 1;
    bool canWatchRescueAd = gameState.isOutOfMoves && gameState.rescueUndos == 0;
    bool hasAdUndos = canWatchGameAd || canWatchRescueAd;
    bool hasAnyUndosLeft = hasFreeUndos || hasAdUndos;

    bool hasUndoHistory = gameState.previousState != null && !gameState.isHammerActive && !gameState.isProcessing;
    final bool canUndo = hasUndoHistory && hasAnyUndosLeft;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        ref.read(audioServiceProvider).play(AppSound.click);
        ref.read(hapticServiceProvider).trigger(AppHaptic.selection);

        Future.microtask(() => Navigator.pop(context));
      },
      child: Scaffold(
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(l10n.appTitle),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppConstants.paddingM),
              child: GestureDetector(
                onTap: () {
                  if (gameState.isProcessing || isHammerBlocking) return;
                  ref.read(audioServiceProvider).play(AppSound.click);
                  ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                  setState(() => _isPaused = true);
                },
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: (isHammerBlocking ? AppColors.primary.withOpacity(0.05) : AppColors.primary.withOpacity(0.15)),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                    border: Border.all(
                      color: isHammerBlocking ? AppColors.primary.withOpacity(0.3) : AppColors.primary,
                      width: 2,
                    ),
                    boxShadow: isHammerBlocking
                        ? []
                        : [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, spreadRadius: 1)],
                  ),
                  child: Icon(
                    Icons.pause,
                    color: isHammerBlocking ? AppColors.primary.withOpacity(0.3) : AppColors.primary,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: (Platform.isAndroid || Platform.isIOS)
            ? const SafeArea(child: AdBannerWidget())
            : null,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 1.0, end: gameState.pulseGift ? 1.3 : 1.0),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: GestureDetector(
                                onTap: () {
                                  if (gameState.isProcessing || _isPaused || isHammerBlocking) return;
                                  ref.read(audioServiceProvider).play(AppSound.click);
                                  ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                  showDialog(
                                      context: context,
                                      builder: (_) => const PowerUpsDialog()
                                  ).then((_) {
                                    ref.read(gameControllerProvider.notifier).onBonusDialogClosed();
                                  });
                                },
                                child: Container(
                                  height: 72, width: 72,
                                  decoration: BoxDecoration(
                                    color: canUseBonuses || gameState.pulseGift ? AppColors.crystalAmber.withOpacity(0.15) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                                    border: Border.all(
                                        color: canUseBonuses || gameState.pulseGift ? AppColors.crystalAmber : AppColors.crystalAmber.withOpacity(0.2),
                                        width: gameState.pulseGift ? 3 : 2
                                    ),
                                    boxShadow: canUseBonuses || gameState.pulseGift ? [BoxShadow(color: AppColors.crystalAmber.withOpacity(0.4), blurRadius: 15, spreadRadius: 2)] : [],
                                  ),
                                  child: Icon(
                                      Icons.card_giftcard,
                                      color: canUseBonuses || gameState.pulseGift ? AppColors.crystalAmber : AppColors.textSecondary.withOpacity(0.3),
                                      size: 32
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: AppConstants.paddingM),

                        Expanded(
                          child: Container(
                            height: 72,
                            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(AppConstants.radiusM),
                              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    l10n.scoreLabel,
                                    style: const TextStyle(color: AppColors.textSecondary, letterSpacing: 2, fontSize: 12, height: 1.1)
                                ),
                                const SizedBox(height: 2),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                        '${gameState.score}',
                                        maxLines: 1,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          height: 1.0,
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: AppConstants.paddingM),

                        GestureDetector(
                          onTap: () {
                            if (gameState.isProcessing || _isPaused || gameState.isHammerActive) return;
                            if (gameState.previousState == null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.nothingToUndo)));
                              return;
                            }
                            if (!hasAnyUndosLeft) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.outOfUndos)));
                              return;
                            }

                            bool success = ref.read(gameControllerProvider.notifier).undo();
                            if (!success && hasAdUndos) {
                              bool earned = false;
                              RewardedAdManager.showAd(
                                onUserEarnedReward: () => earned = true,
                                onAdDismissed: () {
                                  if (earned) {
                                    Future.delayed(const Duration(milliseconds: 500), () {
                                      ref.read(gameControllerProvider.notifier).onAdReward(PowerUpType.undo);
                                    });
                                  }
                                },
                                onAdFailed: () {
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    ref.read(gameControllerProvider.notifier).onAdReward(PowerUpType.undo);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(l10n.adUnavailableUndo)),
                                    );
                                  });
                                },
                              );
                            }
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 72, width: 72,
                                decoration: BoxDecoration(
                                  color: canUndo ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                                  border: Border.all(color: canUndo ? AppColors.primary : AppColors.primary.withOpacity(0.2), width: 2),
                                  boxShadow: canUndo ? [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 10, spreadRadius: 1)] : [],
                                ),
                                child: Icon(
                                    Icons.undo,
                                    color: canUndo ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
                                    size: 32
                                ),
                              ),
                              if (hasUndoHistory)
                                Positioned(
                                  top: -6, right: -6,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: hasAnyUndosLeft ? AppColors.primary : Colors.grey.shade700,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: AppColors.background, width: 2),
                                    ),
                                    child: hasFreeUndos
                                        ? Text(
                                      '${gameState.freeUndos}',
                                      style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    )
                                        : hasAdUndos
                                        ? const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.play_arrow, color: Colors.black, size: 12),
                                        SizedBox(width: 2),
                                        Text('AD', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                        : const Text(
                                      'LIMIT',
                                      style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.paddingL),

                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          const trayHeight = 100.0;
                          final availableHeight = max(0.0, constraints.maxHeight - trayHeight - AppConstants.paddingL);
                          final maxBoardSize = max(0.0, min(constraints.maxWidth, availableHeight));
                          const double borderWidth = 2.0 * 2;
                          final boardPadding = (AppConstants.paddingS * 2) + borderWidth;
                          final cellSize = max(1.0, (maxBoardSize - boardPadding) / gameState.board.width);

                          return DragTarget<Piece>(
                              onWillAcceptWithDetails: (details) => !gameState.isGameOver && !gameState.isProcessing && !_isPaused && !gameState.isOutOfMoves && !gameState.isHammerActive,
                              onAcceptWithDetails: (details) {
                                if (gameState.isGameOver || gameState.isProcessing || _isPaused || gameState.isOutOfMoves || gameState.isHammerActive) return;
                                final RenderBox? boardBox = _boardKey.currentContext?.findRenderObject() as RenderBox?;
                                if (boardBox == null) return;
                                final boardPos = boardBox.localToGlobal(Offset.zero);
                                final boardSize = boardBox.size;
                                final pieceWidth = details.data.width * cellSize;
                                final pieceHeight = details.data.height * cellSize;
                                final liftAmount = cellSize * 1.5;
                                final translation = Offset(-pieceWidth / 2, -pieceHeight - liftAmount);
                                final visualTopLeft = details.offset + translation;
                                final boardRect = Rect.fromLTWH(boardPos.dx, boardPos.dy, boardSize.width, boardSize.height);
                                final pieceRect = Rect.fromLTWH(visualTopLeft.dx, visualTopLeft.dy, pieceWidth, pieceHeight);
                                if (!boardRect.overlaps(pieceRect)) return;
                                final localOffset = visualTopLeft - boardPos;
                                final localX = localOffset.dx - AppConstants.paddingS;
                                final localY = localOffset.dy - AppConstants.paddingS;
                                final x = (localX / cellSize).round().clamp(0, gameState.board.width - 1);
                                final y = (localY / cellSize).round().clamp(0, gameState.board.height - 1);
                                ref.read(gameControllerProvider.notifier).placePiece(details.data, x, y);
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: SizedBox(
                                              width: maxBoardSize, height: maxBoardSize,
                                              child: Container(
                                                key: _boardKey,
                                                child: BoardWidget(cellSize: cellSize, isDraggingOver: candidateData.isNotEmpty),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: AppConstants.paddingL),
                                        SizedBox(
                                          height: trayHeight,
                                          child: PieceTrayWidget(pieces: gameState.pieces, boardCellSize: cellSize),
                                        ),
                                      ],
                                    ),
                                    if (gameState.activePopups.isNotEmpty)
                                      ...gameState.activePopups.map((popup) {
                                        return Positioned(
                                          top: MediaQuery.of(context).size.height * 0.12,
                                          left: 0, right: 0,
                                          child: IgnorePointer(
                                            child: TweenAnimationBuilder<double>(
                                              key: ValueKey(popup.id),
                                              tween: Tween(begin: 0.0, end: 1.0),
                                              duration: const Duration(milliseconds: 3000),
                                              curve: Curves.easeOutBack,
                                              builder: (context, value, child) {
                                                double opacity = 1.0;
                                                if (value < 0.1) opacity = value * 10;
                                                else if (value > 0.8) opacity = 1.0 - ((value - 0.8) / 0.2);

                                                final String mainText = popup.isMiss ? 'MISS +${popup.amount}' : '+${popup.amount}';
                                                final String subText = popup.isMiss ? '' : (popup.isCross ? 'CROSS x10!' : 'COMBO x${popup.comboLevel}!');
                                                final bool showSubText = !popup.isMiss && (popup.isCross || popup.comboLevel > 1);
                                                final Color mainColor = popup.isMiss ? Colors.grey : (popup.isCross ? Colors.orangeAccent : AppColors.primary);
                                                final double mainSize = popup.isMiss ? 32 : 48;

                                                return Opacity(
                                                  opacity: opacity.clamp(0.0, 1.0),
                                                  child: Transform.translate(
                                                    offset: Offset(0, -50 * value),
                                                    child: Column(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Text(mainText, style: TextStyle(fontSize: mainSize, fontWeight: FontWeight.w900, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 6..color = Colors.black87)),
                                                            Text(mainText, style: TextStyle(fontSize: mainSize, fontWeight: FontWeight.w900, color: mainColor, shadows: [Shadow(color: mainColor.withOpacity(0.8), blurRadius: 15), Shadow(color: mainColor, blurRadius: 8)])),
                                                          ],
                                                        ),
                                                        if (showSubText)
                                                          Stack(
                                                            children: [
                                                              Text(subText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2.0, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 3..color = Colors.black87)),
                                                              Text(subText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2.0, color: Colors.white, shadows: [Shadow(color: Colors.white, blurRadius: 8)])),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  ],
                                );
                              }
                          );
                        },
                      ),
                    ),
                  ],
                ),

                if (gameState.isOutOfMoves && !gameState.pulseGift && !_isPaused && !gameState.isHammerActive)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.85),
                      child: Center(
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingL, vertical: AppConstants.paddingM),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent, size: 48),
                                  const SizedBox(height: 12),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(l10n.outOfMovesTitle, style: const TextStyle(color: AppColors.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.5), textAlign: TextAlign.center),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(l10n.outOfMovesBody, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
                                  const SizedBox(height: 24),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.crystalAmber, foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                      minimumSize: const Size(double.infinity, 50),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    icon: const Icon(Icons.card_giftcard),
                                    label: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(l10n.openBonuses, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    ),
                                    onPressed: () {
                                      ref.read(audioServiceProvider).play(AppSound.click);
                                      ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                      ref.read(gameControllerProvider.notifier).openBonusesFromRescue();
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  TextButton(
                                    onPressed: () {
                                      ref.read(audioServiceProvider).play(AppSound.click);
                                      ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                      ref.read(gameControllerProvider.notifier).giveUp();
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(l10n.endSession, style: const TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                if (_isPaused)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.85),
                      child: Center(
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(l10n.pauseTitle, style: const TextStyle(color: AppColors.primary, fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 4)),
                                ),
                                const SizedBox(height: AppConstants.paddingXL),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: AppColors.background, minimumSize: const Size(200, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusM))),
                                  onPressed: () {
                                    ref.read(audioServiceProvider).play(AppSound.click);
                                    ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                    setState(() => _isPaused = false);
                                  },
                                  child: Text(l10n.resume, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: AppConstants.paddingM),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.surface, foregroundColor: AppColors.primary, minimumSize: const Size(200, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusM), side: BorderSide(color: AppColors.primary))),
                                  onPressed: () {
                                    ref.read(audioServiceProvider).play(AppSound.click);
                                    ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                    ref.read(gameControllerProvider.notifier).startNewGame();
                                    setState(() => _isPaused = false);
                                  },
                                  child: Text(l10n.restart, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: AppConstants.paddingM),
                                // FIXED: Replaced Row with Wrap to prevent RenderFlex overflow on narrow screens
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 16,
                                  runSpacing: 8,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        ref.read(settingsProvider.notifier).toggleSound();
                                        ref.read(audioServiceProvider).play(AppSound.click);
                                        ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                      },
                                      icon: Icon(settings.isSoundOn ? Icons.volume_up : Icons.volume_off, color: Colors.white),
                                      label: Text(settings.isSoundOn ? l10n.soundOn : l10n.soundOff, style: const TextStyle(color: Colors.white, fontSize: 16)),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        ref.read(settingsProvider.notifier).toggleVibration();
                                        ref.read(audioServiceProvider).play(AppSound.click);
                                        ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                      },
                                      icon: Icon(settings.isVibrationOn ? Icons.vibration : Icons.smartphone, color: Colors.white),
                                      label: Text(settings.isVibrationOn ? 'VIBRATION: ON' : 'VIBRATION: OFF', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppConstants.paddingL),
                                TextButton.icon(
                                  onPressed: () async {
                                    ref.read(audioServiceProvider).play(AppSound.click);
                                    ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                    await ref.read(gameControllerProvider.notifier).saveCurrentGame();
                                    if (context.mounted) {
                                      setState(() => _isPaused = false);
                                      Navigator.pop(context);
                                    }
                                  },
                                  icon: const Icon(Icons.save, color: AppColors.primary),
                                  label: Text(l10n.saveAndExit, style: const TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(audioServiceProvider).play(AppSound.click);
                                    ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                    setState(() => _isPaused = false);
                                    Navigator.pop(context);
                                  },
                                  child: Text(l10n.exitWithoutSaving, style: const TextStyle(color: Colors.redAccent, fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                if (gameState.isGameOver && !_isPaused)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.85),
                      child: Center(
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingL, vertical: AppConstants.paddingM),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.auto_awesome, color: AppColors.crystalAmber, size: 64),
                                  const SizedBox(height: AppConstants.paddingM),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(l10n.gameOverTitle, style: const TextStyle(color: AppColors.primary, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 2)),
                                  ),
                                  const SizedBox(height: AppConstants.paddingS),
                                  Text(l10n.sessionEnded, style: const TextStyle(color: AppColors.textSecondary, fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                                  const SizedBox(height: AppConstants.paddingL),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(l10n.yourScore(gameState.score), style: const TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: AppConstants.paddingXL),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.background,
                                        padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingXL, vertical: AppConstants.paddingM),
                                        minimumSize: const Size(double.infinity, 50),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusM))
                                    ),
                                    onPressed: () {
                                      ref.read(audioServiceProvider).play(AppSound.click);
                                      ref.read(hapticServiceProvider).trigger(AppHaptic.selection);
                                      ref.read(gameControllerProvider.notifier).restartGame();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.refresh, size: 24),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(l10n.startNewGame, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}