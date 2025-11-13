class ProductAttributes {
  final List<String> contents;
  final String usage;
  final List<String> suitableFor;

  ProductAttributes({
    required this.contents,
    required this.usage,
    required this.suitableFor,
  });

  factory ProductAttributes.fromMap(Map<String, dynamic> map) {
    return ProductAttributes(
      contents: List<String>.from(map['contents'] ?? []),
      usage: map['usage'] ?? '',
      suitableFor: List<String>.from(map['suitableFor'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "contents": contents,
      "usage": usage,
      "suitableFor": suitableFor,
    };
  }
}
