import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/features/game/application/game_controller.dart';
import 'package:energy_blast/features/game/domain/models/crystal_type.dart';
import 'package:energy_blast/shared/widgets/pulsing_surprise_piece.dart';

class BoardWidget extends ConsumerWidget {
  final double cellSize;
  final bool isDraggingOver;

  const BoardWidget({
    super.key,
    required this.cellSize,
    this.isDraggingOver = false,
  });

  Color _getColor(CrystalType type) {
    switch (type) {
      case CrystalType.ruby: return AppColors.crystalRuby;
      case CrystalType.sapphire: return AppColors.crystalSapphire;
      case CrystalType.emerald: return AppColors.crystalEmerald;
      case CrystalType.amber: return AppColors.crystalAmber;
      case CrystalType.empty: return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final board = gameState.board;

    final lineThickness = cellSize * 0.15;
    final auraWidth = lineThickness + (cellSize * 0.5);

    final bool isVerticalRiftActive = gameState.clearingCols.isNotEmpty;
    final bool isHorizontalRiftActive = gameState.clearingRows.isNotEmpty;

    final hintPiece = gameState.hintPieceId != null
        ? gameState.pieces.firstWhere((p) => p.id == gameState.hintPieceId, orElse: () => gameState.pieces.first)
        : null;

    final List<Widget> animatedCells = [];
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
        final cell = board.getCell(x, y);
        if (cell.isEmpty) continue;

        final isActiveSurprise = gameState.activeSurprises.any((pos) => pos.dx == x && pos.dy == y);

        Widget cellWidget;

        if (isActiveSurprise) {
          cellWidget = PulsingSurprisePiece(size: cellSize);
        } else {
          cellWidget = Container(
            margin: EdgeInsets.all(cellSize * 0.05),
            decoration: BoxDecoration(
              color: _getColor(cell.type),
              borderRadius: BorderRadius.circular(cellSize * 0.1),
              boxShadow: [
                BoxShadow(
                  color: _getColor(cell.type).withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ],
            ),
          );
        }

        animatedCells.add(
          AnimatedPositioned(
            key: ValueKey(cell.id),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            left: x * cellSize,
            top: y * cellSize,
            width: cellSize,
            height: cellSize,
            child: cellWidget,
          ),
        );
      }
    }

    final List<Widget> hintWidgets = [];
    if (gameState.hintX != null && gameState.hintY != null && hintPiece != null) {
      for (int dy = 0; dy < hintPiece.height; dy++) {
        for (int dx = 0; dx < hintPiece.width; dx++) {
          if (hintPiece.shape[dy][dx]) {
            hintWidgets.add(
              Positioned(
                left: (gameState.hintX! + dx) * cellSize,
                top: (gameState.hintY! + dy) * cellSize,
                width: cellSize,
                height: cellSize,
                child: IgnorePointer(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.9, end: 1.1),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          margin: EdgeInsets.all(cellSize * 0.05),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.greenAccent, width: 3),
                              borderRadius: BorderRadius.circular(cellSize * 0.1),
                              color: Colors.greenAccent.withValues(alpha: 0.2),
                              boxShadow: [
                                BoxShadow(color: Colors.greenAccent.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)
                              ]
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
        }
      }
    }

    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingS),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(
          color: isDraggingOver ? AppColors.primary : AppColors.boardBorder,
          width: 2,
        ),
        boxShadow: AppConstants.defaultShadow,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // 1. Background Grid
          Column(
            children: List.generate(board.height, (y) {
              return Expanded(
                child: Row(
                  children: List.generate(board.width, (x) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.all(cellSize * 0.05),
                        decoration: BoxDecoration(
                          color: AppColors.boardEmptyCell,
                          borderRadius: BorderRadius.circular(AppConstants.radiusS),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),

          // 2. Gradient Auras around the lines (always visible)
          // Vertical Aura
          Positioned.fill(
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: auraWidth,
                  height: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          Color(0x303D5AFE),
                          Color(0x303D5AFE),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.35, 0.65, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Horizontal Aura
          Positioned.fill(
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  height: auraWidth,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0x303D5AFE),
                          Color(0x303D5AFE),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.35, 0.65, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 3. Gravity Crosshair Lines (Base)
          // Vertical Base Line
          Positioned.fill(
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: lineThickness,
                  height: double.infinity,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) => const LinearGradient(
                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
                      stops: [0.0, 0.15, 0.85, 1.0],
                    ).createShader(bounds),
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft, end: Alignment.centerRight,
                          colors: [Colors.transparent, Color(0x803D5AFE), Color(0xFF0A0815), Color(0x803D5AFE), Colors.transparent],
                          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Horizontal Base Line
          Positioned.fill(
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  height: lineThickness,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) => const LinearGradient(
                      begin: Alignment.centerLeft, end: Alignment.centerRight,
                      colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
                      stops: [0.0, 0.15, 0.85, 1.0],
                    ).createShader(bounds),
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter, end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0x803D5AFE), Color(0xFF0A0815), Color(0x803D5AFE), Colors.transparent],
                          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 4. Active Rift Effects (Lightning + Bright Glow)
          // Active Vertical Rift
          if (isVerticalRiftActive)
            Positioned.fill(
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.center,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, t, child) {
                      double pulse = (1.0 - t) * (0.5 + 0.5 * cos(t * pi * 6));
                      return Opacity(
                        opacity: pulse.clamp(0.0, 1.0),
                        child: SizedBox(
                          width: lineThickness * 3,
                          height: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: lineThickness * 1.5,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyanAccent,
                                      blurRadius: 50 * pulse,
                                      spreadRadius: 20 * pulse,
                                    )
                                  ],
                                ),
                              ),
                              CustomPaint(
                                painter: LightningPainter(isVertical: true, pulse: pulse),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          // Active Horizontal Rift
          if (isHorizontalRiftActive)
            Positioned.fill(
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.center,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, t, child) {
                      double pulse = (1.0 - t) * (0.5 + 0.5 * cos(t * pi * 6));
                      return Opacity(
                        opacity: pulse.clamp(0.0, 1.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: lineThickness * 3,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: lineThickness * 1.5,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyanAccent,
                                      blurRadius: 50 * pulse,
                                      spreadRadius: 20 * pulse,
                                    )
                                  ],
                                ),
                              ),
                              CustomPaint(
                                painter: LightningPainter(isVertical: false, pulse: pulse),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          // 5. Laser Sparks
          ...gameState.clearingRows.map((y) {
            return Positioned(
              left: 0, right: 0, top: y * cellSize, height: cellSize,
              child: IgnorePointer(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey('row_$y'),
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.linear,
                  builder: (context, t, child) {
                    return CustomPaint(
                      size: Size(board.width * cellSize, cellSize),
                      painter: RowSparkPainter(t: t, cellSize: cellSize, width: board.width, seed: y.toDouble()),
                    );
                  },
                ),
              ),
            );
          }),

          ...gameState.clearingCols.map((x) {
            return Positioned(
              left: x * cellSize, top: 0, width: cellSize, height: board.height * cellSize,
              child: IgnorePointer(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey('col_$x'),
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.linear,
                  builder: (context, t, child) {
                    return CustomPaint(
                      size: Size(cellSize, board.height * cellSize),
                      painter: ColSparkPainter(t: t, cellSize: cellSize, height: board.height, seed: x.toDouble() + 10),
                    );
                  },
                ),
              ),
            );
          }),

          // 6. Animated Crystals
          ...animatedCells,

          // 6.5. FLOATING SCORE NUMBERS (WHITE OUTLINE)
          if (gameState.clearingCellPoints.isNotEmpty)
            ...gameState.clearingCellPoints.entries.map((entry) {
              final parts = entry.key.split('_');
              final x = int.parse(parts[0]);
              final y = int.parse(parts[1]);
              final points = entry.value;

              // Get the block's color for the text
              final cell = board.getCell(x, y);
              final blockColor = _getColor(cell.type);

              return Positioned(
                left: x * cellSize,
                top: y * cellSize,
                width: cellSize,
                height: cellSize,
                child: IgnorePointer(
                  child: TweenAnimationBuilder<double>(
                    key: ValueKey('score_${entry.key}'),
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutQuad,
                    builder: (context, t, child) {
                      final dy = -cellSize * 1.2 * t;
                      // Keep at 100% opacity for the first 70% of the flight, then fade out
                      final opacity = t < 0.7 ? 1.0 : (1.0 - t) / 0.3;

                      return Transform.translate(
                        offset: Offset(0, dy),
                        child: Center(
                          child: Opacity(
                            opacity: opacity.clamp(0.0, 1.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // 1. White stroke outline
                                  Text(
                                    '+$points',
                                    style: TextStyle(
                                      fontSize: cellSize * 0.42,
                                      fontWeight: FontWeight.w900,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3.5
                                        ..color = Colors.white,
                                    ),
                                  ),
                                  // 2. Colored fill with neon glow
                                  Text(
                                    '+$points',
                                    style: TextStyle(
                                      fontSize: cellSize * 0.42,
                                      fontWeight: FontWeight.w900,
                                      color: blockColor,
                                      shadows: [
                                        // Adding a tiny dark shadow under the white outline helps pop it further against light areas
                                        const Shadow(color: Colors.black45, blurRadius: 2, offset: Offset(0, 1)),
                                        Shadow(color: blockColor, blurRadius: 10), // Glow matches block color
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),

          // 7. HINT OVERLAY
          ...hintWidgets,

          // 8. HAMMER MISS RIPPLES
          ...gameState.activeHammerMisses.map((miss) {
            return Positioned(
              left: miss.position.dx * cellSize,
              top: miss.position.dy * cellSize,
              width: cellSize,
              height: cellSize,
              child: IgnorePointer(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(miss.id),
                  tween: Tween(begin: 1.0, end: 0.0),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, value, child) {
                    return Center(
                      child: Container(
                        width: cellSize * 0.8 * (1.2 - value),
                        height: cellSize * 0.8 * (1.2 - value),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: value),
                            width: 2,
                          ),
                          color: Colors.white.withValues(alpha: value * 0.2),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),

          // 9. HAMMER OVERLAY
          if (gameState.isHammerActive)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) {
                  final x = (details.localPosition.dx / cellSize).floor().clamp(0, board.width - 1);
                  final y = (details.localPosition.dy / cellSize).floor().clamp(0, board.height - 1);
                  ref.read(gameControllerProvider.notifier).useHammer(x, y);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    border: Border.all(color: Colors.redAccent, width: 4),
                    borderRadius: BorderRadius.circular(AppConstants.radiusL),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// --- CUSTOM PAINTERS ---

// 1. Lightning Painter for the Rift
class LightningPainter extends CustomPainter {
  final bool isVertical;
  final double pulse;

  LightningPainter({required this.isVertical, required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    if (pulse <= 0.01) return;

    for (int i = 0; i < 3; i++) {
      final paint = Paint()
        ..color = i == 0 ? Colors.white : Colors.cyanAccent.withValues(alpha: 0.5)
        ..strokeWidth = i == 0 ? 2.0 : 6.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      if (i == 0) {
        paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);
      }

      final path = Path();
      final random = Random();

      if (isVertical) {
        path.moveTo(size.width / 2, 0);
        double currentX = size.width / 2;

        for (double y = 0; y <= size.height; y += 20) {
          double offset = (random.nextDouble() - 0.5) * 15;
          currentX = (size.width / 2) + offset;
          path.lineTo(currentX, y);
        }
      } else {
        path.moveTo(0, size.height / 2);
        double currentY = size.height / 2;

        for (double x = 0; x <= size.width; x += 20) {
          double offset = (random.nextDouble() - 0.5) * 15;
          currentY = (size.height / 2) + offset;
          path.lineTo(x, currentY);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LightningPainter oldDelegate) => true;
}

double _fract(double x) => x - x.floorToDouble();
double _rand(double seed) => _fract(sin(seed * 12.9898) * 43758.5453);

class RowSparkPainter extends CustomPainter {
  final double t;
  final double cellSize;
  final int width;
  final double seed;

  RowSparkPainter({required this.t, required this.cellSize, required this.width, required this.seed});

  Offset _getSparkPos(double time, bool isTop) {
    final centerY = cellSize / 2;
    final halfCell = cellSize / 2;

    if (time < 0.15) {
      double localT = time / 0.15;
      double dy = localT * halfCell;
      return Offset(0, isTop ? centerY - dy : centerY + dy);
    } else if (time < 0.85) {
      double localT = (time - 0.15) / 0.7;
      double dx = localT * (width * cellSize);
      return Offset(dx, isTop ? centerY - halfCell : centerY + halfCell);
    } else {
      double localT = (time - 0.85) / 0.15;
      double dy = localT * halfCell;
      return Offset(width * cellSize, isTop ? centerY - halfCell + dy : centerY + halfCell - dy);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final topPos = _getSparkPos(t, true);
    final botPos = _getSparkPos(t, false);
    final centerY = cellSize / 2;
    final halfCell = cellSize / 2;

    final glowPaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);

    final corePaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final hotCorePaint = Paint()
      ..color = Colors.yellowAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    Path topPath = Path()..moveTo(0, centerY);
    if (t > 0) topPath.lineTo(0, centerY - min(t / 0.15, 1.0) * halfCell);
    if (t > 0.15) topPath.lineTo(min((t - 0.15) / 0.7, 1.0) * width * cellSize, centerY - halfCell);
    if (t > 0.85) topPath.lineTo(width * cellSize, centerY - halfCell + ((t - 0.85) / 0.15) * halfCell);

    Path botPath = Path()..moveTo(0, centerY);
    if (t > 0) botPath.lineTo(0, centerY + min(t / 0.15, 1.0) * halfCell);
    if (t > 0.15) botPath.lineTo(min((t - 0.15) / 0.7, 1.0) * width * cellSize, centerY + halfCell);
    if (t > 0.85) botPath.lineTo(width * cellSize, centerY + halfCell - ((t - 0.85) / 0.15) * halfCell);

    canvas.drawPath(topPath, glowPaint);
    canvas.drawPath(topPath, corePaint);
    canvas.drawPath(topPath, hotCorePaint);

    canvas.drawPath(botPath, glowPaint);
    canvas.drawPath(botPath, corePaint);
    canvas.drawPath(botPath, hotCorePaint);

    _drawSparkAndParticles(canvas, topPos);
    _drawSparkAndParticles(canvas, botPos);
  }

  void _drawSparkAndParticles(Canvas canvas, Offset pos) {
    final sparkGlow = Paint()..color = Colors.deepOrange..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);
    final sparkPaint = Paint()..color = Colors.yellowAccent;
    canvas.drawCircle(pos, 12, sparkGlow);
    canvas.drawCircle(pos, 6, sparkPaint);
    canvas.drawCircle(pos, 3, Paint()..color = Colors.white);

    for (int i = 0; i < 150; i++) {
      double r1 = _rand(seed + i * 1.5);
      double r2 = _rand(seed + i * 2.3);
      double r3 = _rand(seed + i * 3.1);

      double spawnT = r1 * 0.95;
      double lifeSpan = 0.06;

      if (t > spawnT && t < spawnT + lifeSpan) {
        double age = (t - spawnT) / lifeSpan;

        Offset startPos = _getSparkPos(spawnT, i % 2 == 0);

        double angle = r2 * 2 * pi;
        double speed = (r3 * 100 + 50);

        double px = startPos.dx + cos(angle) * speed * age;
        double py = startPos.dy + sin(angle) * speed * age;

        py += 20 * age * age;

        double alpha = 1.0 - age;
        double pSize = 2.5 * (1.0 - age);

        Paint pPaint = Paint()
          ..color = (r3 > 0.5 ? Colors.orangeAccent : Colors.yellow).withValues(alpha: alpha)
          ..strokeWidth = pSize
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(
            Offset(px, py),
            Offset(px - cos(angle) * pSize * 3, py - sin(angle) * pSize * 3),
            pPaint
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant RowSparkPainter oldDelegate) => oldDelegate.t != t;
}

class ColSparkPainter extends CustomPainter {
  final double t;
  final double cellSize;
  final int height;
  final double seed;

  ColSparkPainter({required this.t, required this.cellSize, required this.height, required this.seed});

  Offset _getSparkPos(double time, bool isLeft) {
    final centerX = cellSize / 2;
    final halfCell = cellSize / 2;

    if (time < 0.15) {
      double localT = time / 0.15;
      double dx = localT * halfCell;
      return Offset(isLeft ? centerX - dx : centerX + dx, 0);
    } else if (time < 0.85) {
      double localT = (time - 0.15) / 0.7;
      double dy = localT * (height * cellSize);
      return Offset(isLeft ? centerX - halfCell : centerX + halfCell, dy);
    } else {
      double localT = (time - 0.85) / 0.15;
      double dx = localT * halfCell;
      return Offset(isLeft ? centerX - halfCell + dx : centerX + halfCell - dx, height * cellSize);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final leftPos = _getSparkPos(t, true);
    final rightPos = _getSparkPos(t, false);
    final centerX = cellSize / 2;
    final halfCell = cellSize / 2;

    final glowPaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);

    final corePaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final hotCorePaint = Paint()
      ..color = Colors.yellowAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    Path leftPath = Path()..moveTo(centerX, 0);
    if (t > 0) leftPath.lineTo(centerX - min(t / 0.15, 1.0) * halfCell, 0);
    if (t > 0.15) leftPath.lineTo(centerX - halfCell, min((t - 0.15) / 0.7, 1.0) * height * cellSize);
    if (t > 0.85) leftPath.lineTo(centerX - halfCell + ((t - 0.85) / 0.15) * halfCell, height * cellSize);

    Path rightPath = Path()..moveTo(centerX, 0);
    if (t > 0) rightPath.lineTo(centerX + min(t / 0.15, 1.0) * halfCell, 0);
    if (t > 0.15) rightPath.lineTo(centerX + halfCell, min((t - 0.15) / 0.7, 1.0) * height * cellSize);
    if (t > 0.85) rightPath.lineTo(centerX + halfCell - ((t - 0.85) / 0.15) * halfCell, height * cellSize);

    canvas.drawPath(leftPath, glowPaint);
    canvas.drawPath(leftPath, corePaint);
    canvas.drawPath(leftPath, hotCorePaint);

    canvas.drawPath(rightPath, glowPaint);
    canvas.drawPath(rightPath, corePaint);
    canvas.drawPath(rightPath, hotCorePaint);

    _drawSparkAndParticles(canvas, leftPos);
    _drawSparkAndParticles(canvas, rightPos);
  }

  void _drawSparkAndParticles(Canvas canvas, Offset pos) {
    final sparkGlow = Paint()..color = Colors.deepOrange..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);
    final sparkPaint = Paint()..color = Colors.yellowAccent;
    canvas.drawCircle(pos, 12, sparkGlow);
    canvas.drawCircle(pos, 6, sparkPaint);
    canvas.drawCircle(pos, 3, Paint()..color = Colors.white);

    for (int i = 0; i < 150; i++) {
      double r1 = _rand(seed + i * 1.5);
      double r2 = _rand(seed + i * 2.3);
      double r3 = _rand(seed + i * 3.1);

      double spawnT = r1 * 0.95;
      double lifeSpan = 0.06;

      if (t > spawnT && t < spawnT + lifeSpan) {
        double age = (t - spawnT) / lifeSpan;

        Offset startPos = _getSparkPos(spawnT, i % 2 == 0);

        double angle = r2 * 2 * pi;
        double speed = (r3 * 100 + 50);

        double px = startPos.dx + cos(angle) * speed * age;
        double py = startPos.dy + sin(angle) * speed * age;

        py += 20 * age * age;

        double alpha = 1.0 - age;
        double pSize = 2.5 * (1.0 - age);

        Paint pPaint = Paint()
          ..color = (r3 > 0.5 ? Colors.orangeAccent : Colors.yellow).withValues(alpha: alpha)
          ..strokeWidth = pSize
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(
            Offset(px, py),
            Offset(px - cos(angle) * pSize * 3, py - sin(angle) * pSize * 3),
            pPaint
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant ColSparkPainter oldDelegate) => oldDelegate.t != t;
}