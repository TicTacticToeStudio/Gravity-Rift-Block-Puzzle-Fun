import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/constants/app_constants.dart';
import 'package:energy_blast/core/theme/app_colors.dart';
import 'package:energy_blast/features/game/application/game_controller.dart';
import 'package:energy_blast/features/game/domain/models/crystal_type.dart';
import 'package:energy_blast/features/game/domain/models/piece.dart';
import 'package:energy_blast/shared/widgets/pulsing_surprise_piece.dart';

class PieceTrayWidget extends ConsumerWidget {
  final List<Piece> pieces;
  final double boardCellSize;

  const PieceTrayWidget({
    super.key,
    required this.pieces,
    required this.boardCellSize,
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingS, horizontal: AppConstants.paddingS),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: AppColors.boardBorder, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: pieces.map((Piece piece) {
          final pieceWidth = piece.width * boardCellSize;
          final pieceHeight = piece.height * boardCellSize;
          final liftAmount = boardCellSize * 1.5;

          final isHinted = gameState.hintPieceId == piece.id;

          Widget draggableChild = Container(
            color: Colors.transparent,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: _buildPieceRaw(piece, boardCellSize * 0.6),
                ),
              ),
            ),
          );

          // Apply Glowing Border if this piece is hinted
          if (isHinted) {
            draggableChild = Container(
              decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  border: Border.all(color: Colors.greenAccent, width: 2),
                  boxShadow: [
                    BoxShadow(color: Colors.greenAccent.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)
                  ]
              ),
              padding: const EdgeInsets.all(4),
              child: draggableChild,
            );
          }

          return Expanded(
            child: Draggable<Piece>(
              data: piece,
              dragAnchorStrategy: pointerDragAnchorStrategy,
              feedback: Transform.translate(
                offset: Offset(-pieceWidth / 2, -pieceHeight - liftAmount),
                child: Material(
                  color: Colors.transparent,
                  child: Opacity(
                    opacity: 0.9,
                    child: _buildPieceRaw(piece, boardCellSize, isDragging: true),
                  ),
                ),
              ),
              childWhenDragging: Container(
                color: Colors.transparent,
                child: Opacity(
                  opacity: 0.2,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: _buildPieceRaw(piece, boardCellSize * 0.6),
                    ),
                  ),
                ),
              ),
              child: draggableChild,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPieceRaw(Piece piece, double size, {bool isDragging = false}) {
    const double margin = 1.0;

    if (piece.isSurprise) {
      return PulsingSurprisePiece(size: size);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(piece.height, (int y) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(piece.width, (int x) {
            final isBlock = piece.shape[y][x];
            return Container(
              width: size,
              height: size,
              padding: const EdgeInsets.all(margin),
              child: Container(
                decoration: BoxDecoration(
                  color: isBlock ? _getColor(piece.type) : Colors.transparent,
                  borderRadius: BorderRadius.circular(size * 0.1),
                  boxShadow: isBlock && isDragging ? [
                    BoxShadow(
                      color: _getColor(piece.type).withOpacity(0.8),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ] : [],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}