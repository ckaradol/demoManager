class Commission {
  final double rate;
  final String description;

  Commission({
    required this.rate,
    required this.description,
  });

  factory Commission.fromMap(Map<String, dynamic> map) {
    return Commission(
      rate: (map['rate'] ?? 0).toDouble(),
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "rate": rate,
      "description": description,
    };
  }
}
