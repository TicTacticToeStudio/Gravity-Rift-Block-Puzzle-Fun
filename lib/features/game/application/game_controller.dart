import 'dart:ui';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/features/game/domain/models/board.dart';
import 'package:energy_blast/features/game/domain/models/crystal_type.dart';
import 'package:energy_blast/features/game/domain/models/piece.dart';
import 'package:energy_blast/core/services/high_score_service.dart';
import 'package:energy_blast/core/services/power_up_service.dart';
import 'package:energy_blast/core/services/save_game_service.dart';

class ScorePopup {
  final String id; final int amount; final bool isCross; final int comboLevel; final Offset position;
  ScorePopup({required this.id, required this.amount, required this.isCross, required this.comboLevel, required this.position});
}

class GameState {
  final String runId;
  final Board board;
  final List<Piece> pieces;
  final int score;
  final bool isGameOver;
  final bool isOutOfMoves;
  final bool isProcessing;
  final List<int> clearingRows;
  final List<int> clearingCols;
  final List<ScorePopup> activePopups;
  final GameState? previousState;

  final int freeSurprises;
  final int freeHammers;
  final int freeShuffles;
  final int freeHints;
  final int freeUndos;

  final int adSurprises;
  final int adHammers;
  final int adShuffles;
  final int adHints;
  final int adUndos;

  final int rescueSurprises;
  final int rescueHammers;
  final int rescueShuffles;
  final int rescueHints;
  final int rescueUndos;

  final List<Offset> activeSurprises;
  final int lastSurprisePoints;
  final bool isHammerActive;
  final int turnId;

  final String? hintPieceId;
  final int? hintX;
  final int? hintY;

  final bool pulseGift;

  const GameState({
    required this.runId,
    required this.board, required this.pieces, this.score = 0,
    this.isGameOver = false, this.isOutOfMoves = false, this.isProcessing = false,
    this.clearingRows = const [], this.clearingCols = const [], this.activePopups = const [], this.previousState,

    this.freeSurprises = 2, this.freeHammers = 2, this.freeShuffles = 2, this.freeHints = 2, this.freeUndos = 3,
    this.adSurprises = 0, this.adHammers = 0, this.adShuffles = 0, this.adHints = 0, this.adUndos = 0,
    this.rescueSurprises = 0, this.rescueHammers = 0, this.rescueShuffles = 0, this.rescueHints = 0, this.rescueUndos = 0,

    this.activeSurprises = const [], this.lastSurprisePoints = 0, this.isHammerActive = false,
    this.turnId = 0, this.hintPieceId, this.hintX, this.hintY,
    this.pulseGift = false,
  });

  GameState copyWith({
    String? runId,
    Board? board, List<Piece>? pieces, int? score, bool? isGameOver, bool? isOutOfMoves, bool? isProcessing,
    List<int>? clearingRows, List<int>? clearingCols, List<ScorePopup>? activePopups,
    GameState? previousState, bool clearPreviousState = false,

    int? freeSurprises, int? freeHammers, int? freeShuffles, int? freeHints, int? freeUndos,
    int? adSurprises, int? adHammers, int? adShuffles, int? adHints, int? adUndos,
    int? rescueSurprises, int? rescueHammers, int? rescueShuffles, int? rescueHints, int? rescueUndos,

    List<Offset>? activeSurprises, int? lastSurprisePoints, bool? isHammerActive, int? turnId,
    String? hintPieceId, int? hintX, int? hintY, bool clearHint = false,
    bool? pulseGift,
  }) {
    return GameState(
      runId: runId ?? this.runId,
      board: board ?? this.board, pieces: pieces ?? this.pieces, score: score ?? this.score,
      isGameOver: isGameOver ?? this.isGameOver, isOutOfMoves: isOutOfMoves ?? this.isOutOfMoves,
      isProcessing: isProcessing ?? this.isProcessing,
      clearingRows: clearingRows ?? this.clearingRows, clearingCols: clearingCols ?? this.clearingCols,
      activePopups: activePopups ?? this.activePopups,
      previousState: clearPreviousState ? null : (previousState ?? this.previousState),

      freeSurprises: freeSurprises ?? this.freeSurprises, freeHammers: freeHammers ?? this.freeHammers,
      freeShuffles: freeShuffles ?? this.freeShuffles, freeHints: freeHints ?? this.freeHints, freeUndos: freeUndos ?? this.freeUndos,
      adSurprises: adSurprises ?? this.adSurprises, adHammers: adHammers ?? this.adHammers,
      adShuffles: adShuffles ?? this.adShuffles, adHints: adHints ?? this.adHints, adUndos: adUndos ?? this.adUndos,
      rescueSurprises: rescueSurprises ?? this.rescueSurprises, rescueHammers: rescueHammers ?? this.rescueHammers,
      rescueShuffles: rescueShuffles ?? this.rescueShuffles, rescueHints: rescueHints ?? this.rescueHints, rescueUndos: rescueUndos ?? this.rescueUndos,

      activeSurprises: activeSurprises ?? this.activeSurprises, lastSurprisePoints: lastSurprisePoints ?? this.lastSurprisePoints,
      isHammerActive: isHammerActive ?? this.isHammerActive,
      turnId: turnId ?? this.turnId,
      hintPieceId: clearHint ? null : (hintPieceId ?? this.hintPieceId),
      hintX: clearHint ? null : (hintX ?? this.hintX),
      hintY: clearHint ? null : (hintY ?? this.hintY),
      pulseGift: pulseGift ?? this.pulseGift,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'runId': runId,
      'score': score, 'board': board.toJson(), 'pieces': pieces.map((p) => p.toJson()).toList(),
      'freeSurprises': freeSurprises, 'freeHammers': freeHammers, 'freeShuffles': freeShuffles, 'freeHints': freeHints, 'freeUndos': freeUndos,
      'adSurprises': adSurprises, 'adHammers': adHammers, 'adShuffles': adShuffles, 'adHints': adHints, 'adUndos': adUndos,
      'rescueSurprises': rescueSurprises, 'rescueHammers': rescueHammers, 'rescueShuffles': rescueShuffles, 'rescueHints': rescueHints, 'rescueUndos': rescueUndos,
    };
  }

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      runId: json['runId'] ?? DateTime.now().microsecondsSinceEpoch.toString(),
      score: json['score'], board: Board.fromJson(json['board']),
      pieces: (json['pieces'] as List).map((p) => Piece.fromJson(p)).toList(),
      freeSurprises: json['freeSurprises'] ?? 2, freeHammers: json['freeHammers'] ?? 2, freeShuffles: json['freeShuffles'] ?? 2, freeHints: json['freeHints'] ?? 2, freeUndos: json['freeUndos'] ?? 3,
      adSurprises: json['adSurprises'] ?? 0, adHammers: json['adHammers'] ?? 0, adShuffles: json['adShuffles'] ?? 0, adHints: json['adHints'] ?? 0, adUndos: json['adUndos'] ?? 0,
      rescueSurprises: json['rescueSurprises'] ?? 0, rescueHammers: json['rescueHammers'] ?? 0, rescueShuffles: json['rescueShuffles'] ?? 0, rescueHints: json['rescueHints'] ?? 0, rescueUndos: json['rescueUndos'] ?? 0,
      isProcessing: false, isGameOver: false, isOutOfMoves: false, isHammerActive: false, pulseGift: false,
    );
  }
}

class GameController extends AutoDisposeNotifier<GameState> {
  final Random _random = Random();
  bool _isDisposed = false;

  @override
  GameState build() {
    ref.onDispose(() => _isDisposed = true);
    return _createInitialState();
  }

  GameState _createInitialState() {
    final board = Board(width: 8, height: 8);
    const int initialBlocksCount = 8;
    int placedBlocks = 0;
    final allColors = [CrystalType.ruby, CrystalType.sapphire, CrystalType.emerald, CrystalType.amber];

    while (placedBlocks < initialBlocksCount) {
      int x = _random.nextInt(board.width);
      int y = _random.nextInt(board.height);
      if (y <= 1) continue;
      if (board.getCell(x, y).isEmpty) {
        board.getCell(x, y).type = allColors[_random.nextInt(allColors.length)];
        placedBlocks++;
      }
    }
    return GameState(
      runId: DateTime.now().microsecondsSinceEpoch.toString(),
      board: board, pieces: _generateNewPieces(board), score: 0, isHammerActive: false, isProcessing: false,
    );
  }

  Future<void> saveCurrentGame() async {
    if (state.isGameOver) return;
    await HighScoreService.saveScore(state.score, state.runId);
    await SaveGameService.saveGame(state.toJson());
  }

  void resumeGame(GameState savedState) {
    state = savedState.copyWith(turnId: state.turnId + 1, isProcessing: false, isGameOver: false, isOutOfMoves: false, clearHint: true, pulseGift: false);
    _checkForGameOver(state.board, state.pieces);
  }

  Future<void> startNewGame() async {
    await SaveGameService.clearSave();
    final newState = _createInitialState().copyWith(turnId: state.turnId + 1);
    state = newState;
  }

  Future<void> restartGame() async => await startNewGame();

  void openBonusesFromRescue() {
    state = state.copyWith(pulseGift: true);
  }

  void onBonusDialogClosed() {
    if (state.pulseGift) {
      _checkForGameOver(state.board, state.pieces);
      state = state.copyWith(pulseGift: false);
    }
  }

  void onAdReward(PowerUpType type) {
    if (type == PowerUpType.surprise) useSurprise();
    if (type == PowerUpType.hammer) toggleHammerMode();
    if (type == PowerUpType.shuffle) useNewBlocks();
    if (type == PowerUpType.hint) useHint();
    if (type == PowerUpType.undo) undo(fromAd: true);
  }

  bool undo({bool fromAd = false}) {
    if (state.isProcessing || state.previousState == null || state.isHammerActive) return true;

    bool canUseFree = state.freeUndos > 0;
    bool canUseRescueAd = state.isOutOfMoves && state.rescueUndos == 0;
    bool canUseGameAd = !state.isOutOfMoves && state.adUndos < 1;

    int newFree = state.freeUndos;
    int newGameAd = state.adUndos;
    int newRescueAd = state.rescueUndos;

    if (fromAd) {
      if (canUseRescueAd) {
        newRescueAd = 1;
      } else if (canUseGameAd) {
        newGameAd = 1;
      } else {
        return false;
      }
    } else {
      if (canUseFree) {
        newFree--;
      } else {
        return false; // Needs ad
      }
    }

    final pointsToKeep = state.lastSurprisePoints;
    GameState restoredState = state.previousState!;
    if (pointsToKeep > 0) {
      restoredState = restoredState.copyWith(score: restoredState.score + pointsToKeep);
    }

    restoredState = restoredState.copyWith(
      freeUndos: newFree,
      adUndos: newGameAd,
      rescueUndos: newRescueAd,
    );

    state = restoredState.copyWith(clearHint: true, pulseGift: false, isOutOfMoves: false);
    _checkForGameOver(state.board, state.pieces);
    saveCurrentGame();
    return true;
  }

  void giveUp() {
    state = state.copyWith(isOutOfMoves: false, isGameOver: true, isProcessing: false, isHammerActive: false, clearHint: true, pulseGift: false);
    HighScoreService.saveScore(state.score, state.runId);
    SaveGameService.clearSave();
  }

  void useSurprise() {
    if (state.isProcessing || state.isGameOver) return;

    bool canUse = false;
    int newFree = state.freeSurprises;
    int newAd = state.adSurprises;
    int newRescue = state.rescueSurprises;

    if (state.freeSurprises > 0) { newFree--; canUse = true; }
    else if (state.isOutOfMoves && state.rescueSurprises == 0) { newRescue = 1; canUse = true; }
    else if (!state.isOutOfMoves && state.adSurprises < 2) { newAd++; canUse = true; }

    if (!canUse) return;

    final surprisePiece = Piece(id: 'surprise_${DateTime.now().microsecondsSinceEpoch}', shape: [[true]], type: CrystalType.amber, isSurprise: true);
    final newPieces = List<Piece>.from(state.pieces)..insert(0, surprisePiece);

    state = state.copyWith(
      pieces: newPieces, freeSurprises: newFree, adSurprises: newAd, rescueSurprises: newRescue,
      isOutOfMoves: false, isProcessing: false, isHammerActive: false, clearHint: true, pulseGift: false,
    );
    saveCurrentGame();
  }

  void toggleHammerMode() {
    if (state.isProcessing || state.isGameOver) return;

    bool canUse = false;
    int newFree = state.freeHammers;
    int newAd = state.adHammers;
    int newRescue = state.rescueHammers;

    if (state.freeHammers > 0) { newFree--; canUse = true; }
    else if (state.isOutOfMoves && state.rescueHammers == 0) { newRescue = 1; canUse = true; }
    else if (!state.isOutOfMoves && state.adHammers < 2) { newAd++; canUse = true; }

    if (!canUse) return;

    state = state.copyWith(
      freeHammers: newFree, adHammers: newAd, rescueHammers: newRescue,
      isHammerActive: true, isOutOfMoves: false, isProcessing: false, clearHint: true, pulseGift: false,
    );
    saveCurrentGame();
  }

  void useHammer(int x, int y) {
    if (!state.isHammerActive || state.isProcessing) return;
    if (state.board.getCell(x, y).isEmpty) {
      state = state.copyWith(isHammerActive: false);
      return;
    }

    final currentSnapshot = GameState(
      runId: state.runId,
      board: state.board.copy(), pieces: List.from(state.pieces), score: state.score,
      freeSurprises: state.freeSurprises, freeHammers: state.freeHammers, freeShuffles: state.freeShuffles, freeHints: state.freeHints, freeUndos: state.freeUndos,
      adSurprises: state.adSurprises, adHammers: state.adHammers, adShuffles: state.adShuffles, adHints: state.adHints, adUndos: state.adUndos,
      rescueSurprises: state.rescueSurprises, rescueHammers: state.rescueHammers, rescueShuffles: state.rescueShuffles, rescueHints: state.rescueHints, rescueUndos: state.rescueUndos,
      lastSurprisePoints: 0,
    );

    final newBoard = state.board;
    newBoard.getCell(x, y).type = CrystalType.empty;

    state = state.copyWith(
      board: newBoard, isHammerActive: false, isProcessing: false,
      previousState: currentSnapshot, clearPreviousState: false, clearHint: true, pulseGift: false,
    );
    _checkForGameOver(newBoard, state.pieces);
    saveCurrentGame();
  }

  void useNewBlocks() {
    if (state.isProcessing || state.isGameOver) return;

    bool canUse = false;
    int newFree = state.freeShuffles;
    int newAd = state.adShuffles;
    int newRescue = state.rescueShuffles;

    if (state.freeShuffles > 0) { newFree--; canUse = true; }
    else if (state.isOutOfMoves && state.rescueShuffles == 0) { newRescue = 1; canUse = true; }
    else if (!state.isOutOfMoves && state.adShuffles < 2) { newAd++; canUse = true; }

    if (!canUse) return;

    final currentSnapshot = GameState(
      runId: state.runId,
      board: state.board.copy(), pieces: List.from(state.pieces), score: state.score,
      freeSurprises: state.freeSurprises, freeHammers: state.freeHammers, freeShuffles: state.freeShuffles, freeHints: state.freeHints, freeUndos: state.freeUndos,
      adSurprises: state.adSurprises, adHammers: state.adHammers, adShuffles: state.adShuffles, adHints: state.adHints, adUndos: state.adUndos,
      rescueSurprises: state.rescueSurprises, rescueHammers: state.rescueHammers, rescueShuffles: state.rescueShuffles, rescueHints: state.rescueHints, rescueUndos: state.rescueUndos,
    );

    List<Piece> newPieces = _generateNewPieces(state.board);
    bool hasEmptySpace = state.board.grid.expand((row) => row).any((cell) => cell.isEmpty);
    bool anyFits = newPieces.any((p) => state.board.canPlaceAnywhere(p));

    if (!anyFits && hasEmptySpace) {
      final allColors = [CrystalType.ruby, CrystalType.sapphire, CrystalType.emerald, CrystalType.amber];
      newPieces[0] = Piece(id: 'rescue_${DateTime.now().microsecondsSinceEpoch}', shape: [[true]], type: allColors[_random.nextInt(allColors.length)]);
    }

    state = state.copyWith(
      pieces: newPieces, freeShuffles: newFree, adShuffles: newAd, rescueShuffles: newRescue,
      isOutOfMoves: false, isProcessing: false, isHammerActive: false,
      previousState: currentSnapshot, clearPreviousState: false, clearHint: true, pulseGift: false,
    );

    _checkForGameOver(state.board, newPieces);
    saveCurrentGame();
  }

  bool useHint() {
    // Allow execution even if isOutOfMoves is true (will fail naturally if no moves)
    if (state.isProcessing || state.isGameOver) return false;

    bool canUse = false;
    int newFree = state.freeHints;
    int newAd = state.adHints;
    int newRescue = state.rescueHints;

    if (state.freeHints > 0) { newFree--; canUse = true; }
    else if (state.isOutOfMoves && state.rescueHints == 0) { newRescue = 1; canUse = true; }
    else if (!state.isOutOfMoves && state.adHints < 2) { newAd++; canUse = true; }

    if (!canUse) return false;

    Piece? bestPiece;
    int bestX = -1;
    int bestY = -1;
    int highestScore = -999999;

    for (var piece in state.pieces) {
      for (int y = 0; y <= state.board.height - piece.height; y++) {
        for (int x = 0; x <= state.board.width - piece.width; x++) {
          if (state.board.canPlacePiece(piece, x, y)) {
            Board tempBoard = state.board.copy();
            tempBoard.placePiece(piece, x, y);
            int score = _evaluateMove(tempBoard, state.board, piece, x, y);
            if (score > highestScore) { highestScore = score; bestPiece = piece; bestX = x; bestY = y; }
          }
        }
      }
    }

    if (bestPiece != null) {
      state = state.copyWith(
        freeHints: newFree, adHints: newAd, rescueHints: newRescue,
        hintPieceId: bestPiece.id, hintX: bestX, hintY: bestY, isOutOfMoves: false, pulseGift: false,
      );
      saveCurrentGame();
      return true;
    }
    return false;
  }

  int _evaluateMove(Board tempBoard, Board originalBoard, Piece piece, int x, int y) {
    int score = 0;
    final lines = tempBoard.findFullLines();
    int numLines = lines['rows']!.length + lines['cols']!.length;
    if (numLines > 0) score += numLines * 1000;

    int holesBefore = _countHoles(originalBoard);
    int holesAfter = _countHoles(tempBoard);
    score -= (holesAfter - holesBefore) * 200;

    int adjacencyCount = 0;
    for (int py = 0; py < piece.height; py++) {
      for (int px = 0; px < piece.width; px++) {
        if (piece.shape[py][px]) {
          int nx = x + px; int ny = y + py;
          if (nx > 0 && !originalBoard.getCell(nx - 1, ny).isEmpty) adjacencyCount++;
          if (nx < originalBoard.width - 1 && !originalBoard.getCell(nx + 1, ny).isEmpty) adjacencyCount++;
          if (ny > 0 && !originalBoard.getCell(nx, ny - 1).isEmpty) adjacencyCount++;
          if (ny < originalBoard.height - 1 && !originalBoard.getCell(nx, ny + 1).isEmpty) adjacencyCount++;
        }
      }
    }
    score += adjacencyCount * 10;
    return score;
  }

  int _countHoles(Board board) {
    int holes = 0;
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
        if (board.getCell(x, y).isEmpty) {
          bool topFilled = y == 0 || !board.getCell(x, y - 1).isEmpty;
          bool bottomFilled = y == board.height - 1 || !board.getCell(x, y + 1).isEmpty;
          bool leftFilled = x == 0 || !board.getCell(x - 1, y).isEmpty;
          bool rightFilled = x == board.width - 1 || !board.getCell(x + 1, y).isEmpty;
          if (topFilled && bottomFilled && leftFilled && rightFilled) holes++;
        }
      }
    }
    return holes;
  }

  Future<void> placePiece(Piece piece, int startX, int startY) async {
    if (state.isGameOver || state.isProcessing || state.isOutOfMoves || state.isHammerActive || !state.board.canPlacePiece(piece, startX, startY)) return;

    final int currentTurnId = state.turnId;
    final int thisTurnId = currentTurnId + 1;

    try {
      List<Piece> snapshotPieces = List.from(state.pieces);
      if (piece.isSurprise) snapshotPieces.removeWhere((p) => p.id == piece.id);

      final currentSnapshot = GameState(
        runId: state.runId,
        board: state.board.copy(), pieces: snapshotPieces, score: state.score,
        freeSurprises: state.freeSurprises, freeHammers: state.freeHammers, freeShuffles: state.freeShuffles, freeHints: state.freeHints, freeUndos: state.freeUndos,
        adSurprises: state.adSurprises, adHammers: state.adHammers, adShuffles: state.adShuffles, adHints: state.adHints, adUndos: state.adUndos,
        rescueSurprises: state.rescueSurprises, rescueHammers: state.rescueHammers, rescueShuffles: state.rescueShuffles, rescueHints: state.rescueHints, rescueUndos: state.rescueUndos,
        lastSurprisePoints: 0,
      );

      final newBoard = state.board;
      newBoard.placePiece(piece, startX, startY);
      List<Piece> newPieces = state.pieces.where((p) => p.id != piece.id).toList();

      state = state.copyWith(
        board: newBoard, pieces: newPieces, activePopups: [], isProcessing: true, lastSurprisePoints: 0,
        turnId: thisTurnId, isGameOver: false, isOutOfMoves: false, clearHint: true, pulseGift: false,
      );

      if (piece.isSurprise) {
        state = state.copyWith(activeSurprises: [Offset(startX.toDouble(), startY.toDouble())]);
        await Future.delayed(const Duration(milliseconds: 1500));
        if (_isDisposed || state.turnId != thisTurnId) return;

        double currentBdi = _calculateBoardDifficulty(newBoard);
        double roll = _random.nextDouble();
        int outcome;

        if (currentBdi > 0.7) { if (roll < 0.6) outcome = 0; else if (roll < 0.9) outcome = 2; else outcome = 1;
        } else if (currentBdi < 0.3) { if (roll < 0.5) outcome = 1; else if (roll < 0.8) outcome = 2; else outcome = 0;
        } else { outcome = _random.nextInt(3); }

        newBoard.getCell(startX, startY).type = CrystalType.empty;
        int bonusPoints = 0; bool isCross = false;

        if (outcome == 0) {
          for (int dy = -1; dy <= 1; dy++) {
            for (int dx = -1; dx <= 1; dx++) {
              int nx = startX + dx; int ny = startY + dy;
              if (nx >= 0 && nx < newBoard.width && ny >= 0 && ny < newBoard.height) {
                if (!newBoard.getCell(nx, ny).isEmpty) { newBoard.getCell(nx, ny).type = CrystalType.empty; bonusPoints += 20; }
              }
            }
          }
          if (bonusPoints == 0) bonusPoints = 100; isCross = true;
        } else if (outcome == 1) {
          final allColors = [CrystalType.ruby, CrystalType.sapphire, CrystalType.emerald, CrystalType.amber];
          for (int dy = -1; dy <= 1; dy++) {
            for (int dx = -1; dx <= 1; dx++) {
              int nx = startX + dx; int ny = startY + dy;
              if (nx >= 0 && nx < newBoard.width && ny >= 0 && ny < newBoard.height) {
                if (newBoard.getCell(nx, ny).isEmpty) { newBoard.getCell(nx, ny).type = allColors[_random.nextInt(allColors.length)]; bonusPoints += 10; }
              }
            }
          }
          if (bonusPoints == 0) bonusPoints = 100;
        } else { bonusPoints = 500; }

        final newPopup = ScorePopup(id: DateTime.now().microsecondsSinceEpoch.toString(), amount: bonusPoints, isCross: isCross, comboLevel: 1, position: const Offset(0, 0));
        state = state.copyWith(board: newBoard, score: state.score + bonusPoints, activePopups: [newPopup], activeSurprises: const [], lastSurprisePoints: outcome == 2 ? bonusPoints : 0);

        await Future.delayed(const Duration(milliseconds: 400));
        if (_isDisposed || state.turnId != thisTurnId) return;
      }

      int cascadeLevel = 1;
      while (true) {
        final cleared = newBoard.findFullLines();
        final int totalLines = cleared['rows']!.length + cleared['cols']!.length;
        if (totalLines == 0) break;

        int stepScore = (totalLines * 80) * ((cleared['rows']!.isNotEmpty && cleared['cols']!.isNotEmpty) ? 10 : 1) * cascadeLevel;
        state = state.copyWith(clearingRows: cleared['rows'], clearingCols: cleared['cols']);

        await Future.delayed(const Duration(milliseconds: 1500));
        if (_isDisposed || state.turnId != thisTurnId) return;

        newBoard.clearSpecificLines(cleared['rows']!, cleared['cols']!);
        newBoard.applyCenterGravity(cleared['rows']!, cleared['cols']!);

        final newPopup = ScorePopup(id: DateTime.now().microsecondsSinceEpoch.toString(), amount: stepScore, isCross: cleared['rows']!.isNotEmpty && cleared['cols']!.isNotEmpty, comboLevel: cascadeLevel, position: const Offset(0, 0));
        state = state.copyWith(board: newBoard, clearingRows: const [], clearingCols: const [], score: state.score + stepScore, activePopups: [newPopup]);

        await Future.delayed(const Duration(milliseconds: 400));
        if (_isDisposed || state.turnId != thisTurnId) return;
        cascadeLevel++;
      }

      if (newPieces.isEmpty) newPieces = _generateNewPieces(newBoard);

      state = state.copyWith(board: newBoard, pieces: newPieces, isProcessing: false, previousState: currentSnapshot, clearPreviousState: false);
      _checkForGameOver(newBoard, newPieces);
      saveCurrentGame();

    } catch (e) {
      debugPrint('Error in placePiece: $e');
      if (!_isDisposed && state.turnId == thisTurnId) {
        state = state.copyWith(isProcessing: false);
      }
    }
  }

  void _checkForGameOver(Board board, List<Piece> pieces) {
    bool noMovesLeft = true;
    for (var p in pieces) { if (board.canPlaceAnywhere(p)) { noMovesLeft = false; break; } }

    if (noMovesLeft) {
      bool canUseAnyBonus =
          (state.freeSurprises > 0 || state.rescueSurprises == 0 || state.adSurprises < 2) ||
              (state.freeHammers > 0 || state.rescueHammers == 0 || state.adHammers < 2) ||
              (state.freeShuffles > 0 || state.rescueShuffles == 0 || state.adShuffles < 2) ||
              (state.freeHints > 0 || state.rescueHints == 0 || state.adHints < 2) ||
              (state.freeUndos > 0 || state.rescueUndos == 0 || state.adUndos < 1);

      if (canUseAnyBonus) {
        state = state.copyWith(isOutOfMoves: true, isGameOver: false, pulseGift: false);
      } else {
        state = state.copyWith(isGameOver: true, isOutOfMoves: false, pulseGift: false);
        HighScoreService.saveScore(state.score, state.runId);
        SaveGameService.clearSave();
      }
    } else {
      state = state.copyWith(isOutOfMoves: false, isGameOver: false, pulseGift: false);
    }
  }

  List<Piece> _generateNewPieces(Board currentBoard, {bool forceSmall = false}) {
    final double bdi = _calculateBoardDifficulty(currentBoard);
    final List<List<List<bool>>> selectedShapes = [];

    if (forceSmall || bdi > 0.7) {
      selectedShapes.addAll([_getRandomShape(_safeShapes), _getRandomShape(_safeShapes), _getRandomShape(_safeShapes)]);
    } else if (bdi < 0.3) {
      selectedShapes.addAll([_getRandomShape(_safeShapes), _getRandomShape(_mediumShapes), _getRandomShape(_complexShapes)]);
    } else {
      selectedShapes.addAll([_getRandomShape(_safeShapes), _getRandomShape(_mediumShapes), _getRandomShape(_mediumShapes)]);
    }

    final pieces = <Piece>[];
    final colors = _generateColors();
    for (int i = 0; i < 3; i++) {
      List<List<bool>> shape = selectedShapes[i];
      int rotations = _random.nextInt(4);
      for (int r = 0; r < rotations; r++) shape = _rotateShape(shape);
      Piece newPiece = Piece(id: DateTime.now().microsecondsSinceEpoch.toString() + i.toString(), shape: shape, type: colors[i]);

      int attempts = 0;
      while (!currentBoard.canPlaceAnywhere(newPiece) && attempts < 10) {
        if (forceSmall) { shape = [[true]]; } else { shape = _getRandomShape(_safeShapes); }
        int newRotations = _random.nextInt(4);
        for (int r = 0; r < newRotations; r++) shape = _rotateShape(shape);
        newPiece = Piece(id: newPiece.id, shape: shape, type: colors[i]);
        attempts++;
      }
      pieces.add(newPiece);
    }
    pieces.shuffle(_random);
    return pieces;
  }

  double _calculateBoardDifficulty(Board board) {
    int filledCells = 0; int isolatedEmptyCells = 0;
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
        if (!board.getCell(x, y).isEmpty) { filledCells++; } else {
          bool t = y == 0 || !board.getCell(x, y - 1).isEmpty; bool b = y == board.height - 1 || !board.getCell(x, y + 1).isEmpty;
          bool l = x == 0 || !board.getCell(x - 1, y).isEmpty; bool r = x == board.width - 1 || !board.getCell(x + 1, y).isEmpty;
          if (t && b && l && r) isolatedEmptyCells++;
        }
      }
    }
    return (((filledCells / (board.width * board.height)) * 0.7) + ((isolatedEmptyCells / (board.width * board.height * 0.2)) * 0.3)).clamp(0.0, 1.0);
  }

  List<List<bool>> _getRandomShape(List<List<List<bool>>> list) => list[_random.nextInt(list.length)];
  List<List<bool>> _rotateShape(List<List<bool>> shape) {
    int height = shape.length; int width = shape[0].length;
    List<List<bool>> rotated = List.generate(width, (y) => List.generate(height, (x) => false));
    for (int y = 0; y < height; y++) { for (int x = 0; x < width; x++) { rotated[x][height - 1 - y] = shape[y][x]; } }
    return rotated;
  }
  List<CrystalType> _generateColors() {
    final allColors = [CrystalType.ruby, CrystalType.sapphire, CrystalType.emerald, CrystalType.amber];
    final colors = <CrystalType>[]; final primary = allColors[_random.nextInt(allColors.length)]; colors.add(primary);
    if (_random.nextBool()) { colors.add(primary); } else { colors.add(allColors.where((c) => c != primary).toList()[_random.nextInt(3)]); }
    if (colors[0] == colors[1]) { colors.add(allColors.where((c) => c != primary).toList()[_random.nextInt(3)]); } else { colors.add(allColors[_random.nextInt(allColors.length)]); }
    return colors;
  }
  final List<List<List<bool>>> _safeShapes = [[[true]], [[true, true]], [[true], [true]], [[true, true], [true, true]], [[true, false], [true, true]]];
  final List<List<List<bool>>> _mediumShapes = [[[true, true, true]], [[true], [true], [true]], [[true, false], [true, true]], [[true, true, true], [false, true, false]], [[true, true, false], [false, true, true]]];
  final List<List<List<bool>>> _complexShapes = [[[true, true, true, true]], [[true], [true], [true], [true]], [[true, true, true], [true, true, true], [true, true, true]], [[false, true, false], [true, true, true], [false, true, false]], [[true, true, true, true, true]]];
}

final gameControllerProvider = NotifierProvider.autoDispose<GameController, GameState>(GameController.new);