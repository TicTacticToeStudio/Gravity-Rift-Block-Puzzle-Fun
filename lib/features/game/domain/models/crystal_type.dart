enum CrystalType {
  ruby,
  sapphire,
  emerald,
  amber,
  empty,
}

extension CrystalTypePoints on CrystalType {
  int get points {
    switch (this) {
      case CrystalType.ruby:
        return 9;
      case CrystalType.sapphire:
        return 10;
      case CrystalType.emerald:
        return 11;
      case CrystalType.amber:
        return 12;
      case CrystalType.empty:
        return 0;
    }
  }
}