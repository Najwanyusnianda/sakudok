enum ProactiveCardType {
  expiryReminder,
  bundleProgress,
  smartSuggestion,
  recentActivity,
}

class ProactiveCard {
  final String id;
  final ProactiveCardType type;
  final String title;
  final String? description;
  final dynamic data;

  ProactiveCard({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    this.data,
  });
} 