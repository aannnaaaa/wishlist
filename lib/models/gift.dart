enum GiftPriority { low, medium, high }

class Gift {
  final String name;
  final String description;
  final String? imageUrl;
  final String? link;
  final GiftPriority priority;

  Gift({
    required this.name,
    required this.description,
    this.imageUrl,
    this.link,
    this.priority = GiftPriority.medium,
  });

  Gift copyWith({
    String? name,
    String? description,
    String? imageUrl,
    String? link,
    GiftPriority? priority,
  }) {
    return Gift(
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      link: link ?? this.link,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'link': link,
      'priority': priority.index,
    };
  }

  factory Gift.fromMap(Map<String, dynamic> map) {
    return Gift(
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String?,
      link: map['link'] as String?,
      priority: map['priority'] != null
          ? GiftPriority.values[map['priority'] as int]
          : GiftPriority.medium,
    );
  }
}
