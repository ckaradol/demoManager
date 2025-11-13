class Stock {
  final int total;
  final int criticalLevel;
  final String skt;

  Stock({
    required this.total,
    required this.criticalLevel,
    required this.skt,
  });

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      total: map['total'] ?? 0,
      criticalLevel: map['criticalLevel'] ?? 0,
      skt: map['skt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "criticalLevel": criticalLevel,
      "skt": skt,
    };
  }
}
