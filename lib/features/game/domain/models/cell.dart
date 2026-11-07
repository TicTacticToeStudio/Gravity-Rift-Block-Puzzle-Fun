import 'dart:math';
import 'crystal_type.dart';

class Cell {
  final String id;
  CrystalType type;

  Cell({
    this.type = CrystalType.empty,
    String? id,
  }) : id = id ?? '${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(1000000)}';

  bool get isEmpty => type == CrystalType.empty;

  Cell copy() {
    return Cell(
      id: id,
      type: type,
    );
  }

  Cell copyWith({CrystalType? type}) {
    return Cell(
      id: id,
      type: type ?? this.type,
    );
  }
}