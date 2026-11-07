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

    final centerX = 4 * cellSize;
    final centerY = 4 * cellSize;
    final lineThickness = cellSize * 0.12;

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
                  color: _getColor(cell.type).withOpacity(0.5),
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
                              color: Colors.greenAccent.withOpacity(0.2),
                              boxShadow: [
                                BoxShadow(color: Colors.greenAccent.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)
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
      child: Stack(
        children: [
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

          // Gravity Crosshair Lines
          Positioned(
            left: centerX - (lineThickness / 2),
            top: 0,
            bottom: 0,
            child: ShaderMask(
              shaderCallback: (Rect bounds) => const LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
                stops: [0.0, 0.15, 0.85, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: Container(
                width: lineThickness,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft, end: Alignment.centerRight,
                    colors: [Colors.transparent, Color(0x8000E5FF), Color(0xFF0A0815), Color(0x8000E5FF), Colors.transparent],
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(lineThickness / 2),
                ),
              ),
            ),
          ),
          Positioned(
            top: centerY - (lineThickness / 2),
            left: 0,
            right: 0,
            child: ShaderMask(
              shaderCallback: (Rect bounds) => const LinearGradient(
                begin: Alignment.centerLeft, end: Alignment.centerRight,
                colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
                stops: [0.0, 0.15, 0.85, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: Container(
                height: lineThickness,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0x8000E5FF), Color(0xFF0A0815), Color(0x8000E5FF), Colors.transparent],
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(lineThickness / 2),
                ),
              ),
            ),
          ),
          Positioned(
            left: centerX - (cellSize * 1.2),
            top: centerY - (cellSize * 1.2),
            width: cellSize * 2.4,
            height: cellSize * 2.4,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [const Color(0xFF0A0815).withOpacity(1.0), AppColors.primary.withOpacity(0.5), AppColors.primary.withOpacity(0.0)],
                  stops: const [0.0, 0.35, 1.0],
                ),
              ),
            ),
          ),

          ...gameState.clearingRows.map((y) {
            return Positioned(
              left: 0, right: 0, top: y * cellSize, height: cellSize,
              child: IgnorePointer(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey('row_$y'),
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000),
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
                  duration: const Duration(milliseconds: 1000),
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

          ...animatedCells,

          ...hintWidgets,

          // Hammer Miss Ripples
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
                  duration: const Duration(milliseconds: 200), // <-- Синхронизировано с контроллером
                  builder: (context, value, child) {
                    return Center(
                      child: Container(
                        width: cellSize * 0.8 * (1.2 - value),
                        height: cellSize * 0.8 * (1.2 - value),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(value),
                            width: 2,
                          ),
                          color: Colors.white.withOpacity(value * 0.2),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),

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
                    color: Colors.redAccent.withOpacity(0.15),
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
      ..color = Colors.red.withOpacity(0.8)
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
          ..color = (r3 > 0.5 ? Colors.orangeAccent : Colors.yellow).withOpacity(alpha)
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
      ..color = Colors.red.withOpacity(0.8)
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
          ..color = (r3 > 0.5 ? Colors.orangeAccent : Colors.yellow).withOpacity(alpha)
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