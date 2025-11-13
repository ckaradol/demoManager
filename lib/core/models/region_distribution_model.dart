class RegionDistribution {
  final int ege;
  final int marmara;
  final int akdeniz;
  final int dogu;

  RegionDistribution({
    required this.ege,
    required this.marmara,
    required this.akdeniz,
    required this.dogu,
  });

  factory RegionDistribution.fromMap(Map<String, dynamic> map) {
    return RegionDistribution(
      ege: map['Ege'] ?? 0,
      marmara: map['Marmara'] ?? 0,
      akdeniz: map['Akdeniz'] ?? 0,
      dogu: map['Doğu'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Ege": ege,
      "Marmara": marmara,
      "Akdeniz": akdeniz,
      "Doğu": dogu,
    };
  }
}
