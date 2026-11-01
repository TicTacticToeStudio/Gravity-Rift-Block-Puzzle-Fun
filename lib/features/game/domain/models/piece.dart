import 'crystal_type.dart';

class Piece {
  final String id;
  final List<List<bool>> shape;
  final CrystalType type;
  final bool isSurprise;

  const Piece({
    required this.id,
    required this.shape,
    required this.type,
    this.isSurprise = false,
  });

  int get height => shape.length;
  int get width => shape.isNotEmpty ? shape[0].length : 0;
  int get blockCount => shape.expand((row) => row).where((isBlock) => isBlock).length;

  // Превращаем фигуру в Map для сохранения
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'shape': shape.map((row) => row.map((e) => e ? 1 : 0).toList()).toList(),
      'isSurprise': isSurprise,
    };
  }

  // Восстанавливаем фигуру из Map
  factory Piece.fromJson(Map<String, dynamic> json) {
    return Piece(
      id: json['id'],
      type: CrystalType.values[json['type']],
      shape: (json['shape'] as List).map((row) => (row as List).map((e) => e == 1).toList()).toList(),
      isSurprise: json['isSurprise'] ?? false,
    );
  }
}