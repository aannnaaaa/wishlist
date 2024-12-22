import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/calendar_event.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool _isExpanded = false;
  Map<DateTime, List<CalendarEvent>> _events = {};
  bool _hasShownTutorial = false;
  Map<DateTime, List<CalendarEvent>> _friendEvents = {};

  final Map<DateTime, List<CalendarEvent>> _holidays = {
    DateTime.utc(2024, 1, 1): [
      CalendarEvent(
        id: 'h1',
        name: "New Year's Day",
        description: "Happy New Year!",
        date: DateTime.utc(2024, 1, 1),
        category: "Holiday",
      ),
    ],
    DateTime.utc(2024, 2, 14): [
      CalendarEvent(
        id: 'h2',
        name: "Valentine's Day",
        description: "Day of love and romance",
        date: DateTime.utc(2024, 2, 14),
        category: "Holiday",
      ),
    ],
    DateTime.utc(2024, 3, 8): [
      CalendarEvent(
        id: 'h3',
        name: "International Women's Day",
        description: "Celebrating women worldwide",
        date: DateTime.utc(2024, 3, 8),
        category: "Holiday",
      ),
    ],
    DateTime.utc(2024, 12, 25): [
      CalendarEvent(
        id: 'h4',
        name: "Christmas",
        description: "Merry Christmas!",
        date: DateTime.utc(2024, 12, 25),
        category: "Holiday",
      ),
    ],
    DateTime.utc(2024, 12, 31): [
      CalendarEvent(
        id: 'h5',
        name: "New Year's Eve",
        description: "Last day of the year",
        date: DateTime.utc(2024, 12, 31),
        category: "Holiday",
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _holidays.forEach((date, events) {
      if (_events[date] == null) {
        _events[date] = [];
      }
      _events[date]!.addAll(events);
    });

    _animationController.forward();

    _loadFriendEvents();
  }

  void _loadFriendEvents() {
    _friendEvents[DateTime.utc(2025, 1, 20)] = [
      CalendarEvent(
        id: 'f1',
        name: "Friend's Birthday",
        description: "Celebration at friend's place",
        date: DateTime.utc(2025, 1, 20),
        category: "Friend Event",
      ),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  List<CalendarEvent> _getFriendEventsForDay(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    return _friendEvents[normalizedDay] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _animationController.forward(from: 0.0);
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  void _showTutorialIfNeeded(BuildContext context) {
    if (!_hasShownTutorial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Quick Tip',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF48407D),
              ),
            ),
            content: Text(
              'Swipe events left to delete them.\nTap on an event to edit it.',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF48407D),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _hasShownTutorial = true);
                },
                child: Text(
                  'Got it!',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFF48407D),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }
  }

  void _showEditDialog(CalendarEvent event) {
    final nameController = TextEditingController(text: event.name);
    final descriptionController =
        TextEditingController(text: event.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Event',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFF48407D),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                labelStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF48407D),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF48407D),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF48407D),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedEvent = CalendarEvent(
                id: event.id,
                name: nameController.text,
                description: descriptionController.text,
                date: event.date,
                category: event.category,
              );

              setState(() {
                final events = _events[event.date] ?? [];
                final index = events.indexWhere((e) => e.id == event.id);
                if (index != -1) {
                  events[index] = updatedEvent;
                  _events[event.date] = events;
                }
              });

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF48407D),
            ),
            child: Text(
              'Save',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Event',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFF48407D),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                labelStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF48407D),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF48407D),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF48407D),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final normalizedDate = DateTime.utc(
                  _selectedDay.year,
                  _selectedDay.month,
                  _selectedDay.day,
                );

                final newEvent = CalendarEvent(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  description: descriptionController.text.isNotEmpty
                      ? descriptionController.text
                      : null,
                  date: normalizedDate,
                  category: "Event",
                );

                setState(() {
                  if (_events[normalizedDate] == null) {
                    _events[normalizedDate] = [];
                  }
                  _events[normalizedDate]!.add(newEvent);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Event added successfully',
                      style: TextStyle(fontFamily: 'Roboto'),
                    ),
                    backgroundColor: Color(0xFF48407D),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF48407D),
            ),
            child: Text(
              'Add',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _showTutorialIfNeeded(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE5DDFE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF48407D)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Calendar",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: Color(0xFF48407D),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isExpanded ? Icons.view_week : Icons.calendar_month,
                color: Color(0xFF48407D)),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _calendarFormat = CalendarFormat.week;
                } else {
                  _calendarFormat = CalendarFormat.month;
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE5DDFE), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isExpanded ? 100 : 80,
              child: Card(
                margin: EdgeInsets.all(8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.event,
                      color: Color(0xFF48407D),
                      size: 32,
                    ),
                    title: Text(
                      "${_selectedDay.day} ${_getMonthName(_selectedDay.month)} ${_selectedDay.year}",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF48407D),
                      ),
                    ),
                    subtitle: Text(
                      "${_getEventsForDay(_selectedDay).length} events today",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFA192EA),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                  _isExpanded = format == CalendarFormat.week;
                });
              },
              eventLoader: (day) {
                return [
                  ..._getEventsForDay(day),
                  ..._getFriendEventsForDay(day),
                ];
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0xFF48407D).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF48407D),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFA192EA),
                    width: 2,
                  ),
                ),
                markerSize: 8,
                markersMaxCount: 4,
                markerMargin: const EdgeInsets.symmetric(horizontal: 0.3),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF48407D),
                  fontSize: 20,
                ),
                leftChevronIcon:
                    Icon(Icons.chevron_left, color: Color(0xFF48407D)),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: Color(0xFF48407D)),
              ),
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _animationController,
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: _getEventsForDay(_selectedDay).length +
                          _getFriendEventsForDay(_selectedDay).length,
                      itemBuilder: (context, index) {
                        if (index < _getEventsForDay(_selectedDay).length) {
                          final event = _getEventsForDay(_selectedDay)[index];
                          return _buildEventCard(event);
                        } else {
                          final friendEvent =
                              _getFriendEventsForDay(_selectedDay)[index -
                                  _getEventsForDay(_selectedDay).length];
                          return _buildEventCard(friendEvent);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        backgroundColor: Color(0xFF48407D),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventCard(CalendarEvent event) {
    final isFriendEvent = _getFriendEventsForDay(event.date).contains(event);

    return Dismissible(
      key: Key(event.id),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.red),
      ),
      direction:
          isFriendEvent ? DismissDirection.none : DismissDirection.endToStart,
      onDismissed: (direction) {
        if (!isFriendEvent) {
          setState(() {
            _events[_selectedDay]?.remove(event);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Event deleted',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
              backgroundColor: Color(0xFF48407D),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            if (!isFriendEvent) {
              _showEditDialog(event);
            }
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFF48407D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.event,
                    color: Color(0xFF48407D),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF48407D),
                        ),
                      ),
                      if (event.description != null) ...[
                        SizedBox(height: 4),
                        Text(
                          event.description!,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: Color(0xFFA192EA),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Color(0xFF48407D),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
