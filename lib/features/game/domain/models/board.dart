import 'cell.dart';
import 'piece.dart';
import 'crystal_type.dart';

class Board {
  final int width;
  final int height;
  final List<List<Cell>> grid;

  Board({required this.width, required this.height})
      : grid = List.generate(
    height,
        (_) => List.generate(
      width,
          (_) => Cell(),
    ),
  );

  Cell getCell(int x, int y) => grid[y][x];

  // Creates a deep copy of the board (used for snapshots and hint evaluation)
  Board copy() {
    final newBoard = Board(width: width, height: height);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        newBoard.grid[y][x] = grid[y][x].copy();
      }
    }
    return newBoard;
  }

  // Checks if a piece can be placed at the given coordinates
  bool canPlacePiece(Piece piece, int startX, int startY) {
    if (startX + piece.width > width || startY + piece.height > height) return false;
    for (int py = 0; py < piece.height; py++) {
      for (int px = 0; px < piece.width; px++) {
        if (piece.shape[py][px] && !getCell(startX + px, startY + py).isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  // Checks if the piece can be placed anywhere on the board
  bool canPlaceAnywhere(Piece piece) {
    for (int y = 0; y <= height - piece.height; y++) {
      for (int x = 0; x <= width - piece.width; x++) {
        if (canPlacePiece(piece, x, y)) return true;
      }
    }
    return false;
  }

  // Places a piece on the board
  void placePiece(Piece piece, int startX, int startY) {
    for (int py = 0; py < piece.height; py++) {
      for (int px = 0; px < piece.width; px++) {
        if (piece.shape[py][px]) {
          getCell(startX + px, startY + py).type = piece.type;
        }
      }
    }
  }

  // Finds all full rows and columns
  Map<String, List<int>> findFullLines() {
    List<int> fullRows = [];
    List<int> fullCols = [];

    for (int y = 0; y < height; y++) {
      bool isFull = true;
      for (int x = 0; x < width; x++) {
        if (grid[y][x].isEmpty) { isFull = false; break; }
      }
      if (isFull) fullRows.add(y);
    }

    for (int x = 0; x < width; x++) {
      bool isFull = true;
      for (int y = 0; y < height; y++) {
        if (grid[y][x].isEmpty) { isFull = false; break; }
      }
      if (isFull) fullCols.add(x);
    }

    return {'rows': fullRows, 'cols': fullCols};
  }

  // Clears specific rows and columns
  void clearSpecificLines(List<int> rows, List<int> cols) {
    for (int y in rows) {
      for (int x = 0; x < width; x++) {
        grid[y][x].type = CrystalType.empty;
      }
    }
    for (int x in cols) {
      for (int y = 0; y < height; y++) {
        grid[y][x].type = CrystalType.empty;
      }
    }
  }

  // Applies center gravity to pull blocks towards the middle
  void applyCenterGravity(List<int> clearedRows, List<int> clearedCols) {
    // 1. Horizontal Gravity
    if (clearedCols.isNotEmpty) {
      final leftCleared = clearedCols.where((x) => x < 4).toList();
      if (leftCleared.isNotEmpty) {
        int maxX = leftCleared.reduce((a, b) => a > b ? a : b);
        for (int y = 0; y < height; y++) {
          int writeX = 3;
          while (writeX > maxX && !grid[y][writeX].isEmpty) { writeX--; }
          for (int x = maxX; x >= 0; x--) {
            if (!grid[y][x].isEmpty) {
              if (x != writeX) {
                final temp = grid[y][writeX];
                grid[y][writeX] = grid[y][x];
                grid[y][x] = temp;
              }
              writeX--;
            }
          }
        }
      }

      final rightCleared = clearedCols.where((x) => x >= 4).toList();
      if (rightCleared.isNotEmpty) {
        int minX = rightCleared.reduce((a, b) => a < b ? a : b);
        for (int y = 0; y < height; y++) {
          int writeX = 4;
          while (writeX < minX && !grid[y][writeX].isEmpty) { writeX++; }
          for (int x = minX; x < width; x++) {
            if (!grid[y][x].isEmpty) {
              if (x != writeX) {
                final temp = grid[y][writeX];
                grid[y][writeX] = grid[y][x];
                grid[y][x] = temp;
              }
              writeX++;
            }
          }
        }
      }
    }

    // 2. Vertical Gravity
    if (clearedRows.isNotEmpty) {
      final topCleared = clearedRows.where((y) => y < 4).toList();
      if (topCleared.isNotEmpty) {
        int maxY = topCleared.reduce((a, b) => a > b ? a : b);
        for (int x = 0; x < width; x++) {
          int writeY = 3;
          while (writeY > maxY && !grid[writeY][x].isEmpty) { writeY--; }
          for (int y = maxY; y >= 0; y--) {
            if (!grid[y][x].isEmpty) {
              if (y != writeY) {
                final temp = grid[writeY][x];
                grid[writeY][x] = grid[y][x];
                grid[y][x] = temp;
              }
              writeY--;
            }
          }
        }
      }

      final bottomCleared = clearedRows.where((y) => y >= 4).toList();
      if (bottomCleared.isNotEmpty) {
        int minY = bottomCleared.reduce((a, b) => a < b ? a : b);
        for (int x = 0; x < width; x++) {
          int writeY = 4;
          while (writeY < minY && !grid[writeY][x].isEmpty) { writeY++; }
          for (int y = minY; y < height; y++) {
            if (!grid[y][x].isEmpty) {
              if (y != writeY) {
                final temp = grid[writeY][x];
                grid[writeY][x] = grid[y][x];
                grid[y][x] = temp;
              }
              writeY++;
            }
          }
        }
      }
    }
  }

  // Serializes the board to JSON format for saving
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'grid': grid.map((row) => row.map((cell) => cell.type.index).toList()).toList(),
    };
  }

  // Restores the board from JSON format
  factory Board.fromJson(Map<String, dynamic> json) {
    final board = Board(width: json['width'], height: json['height']);
    final List<dynamic> gridJson = json['grid'];
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
        board.grid[y][x].type = CrystalType.values[gridJson[y][x]];
      }
    }
    return board;
  }
}