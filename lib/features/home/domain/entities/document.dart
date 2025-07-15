class Document {
  final String id;
  final String title;
  final String? description;
  final DateTime? expiryDate;
  final bool isFavorite;

  Document({
    required this.id,
    required this.title,
    this.description,
    this.expiryDate,
    this.isFavorite = false,
  });
} 