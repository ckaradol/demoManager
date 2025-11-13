String categoryAvatar(String text) {
  if (text.isEmpty) return "";

  final parts = text.trim().split(RegExp(r"\s+")); // birden fazla boşluk için güvenli
  String initials = "";

  for (var p in parts) {
    if (p.isNotEmpty) {
      initials += p[0].toUpperCase();
    }
  }

  return initials;
}