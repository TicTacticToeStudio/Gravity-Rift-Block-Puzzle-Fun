import 'crystal_type.dart';

class Cell {
  final int x;
  final int y;
  final String id;
  CrystalType type;

  Cell({
    required this.x,
    required this.y,
    this.type = CrystalType.empty,
    String? id,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch.toString() + x.toString() + y.toString();

  bool get isEmpty => type == CrystalType.empty;

  Cell copy() {
    return Cell(
      x: x,
      y: y,
      type: type,
      id: id,
    );
  }

  Cell copyWith({CrystalType? type}) {
    return Cell(
      x: x,
      y: y,
      type: type ?? this.type,
      id: id,
    );
  }
}