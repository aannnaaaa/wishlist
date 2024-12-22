class CalendarEvent {
  final String id;
  final String name;
  final String? description;
  final DateTime date;
  final String category;

  CalendarEvent({
    required this.id,
    required this.name,
    this.description,
    required this.date,
    required this.category,
  });
}
