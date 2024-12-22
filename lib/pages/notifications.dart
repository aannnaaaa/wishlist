import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  NotificationType? _selectedFilter;

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "New Gift Added to Wishlist",
      description: "Your friend Emma added 'iPhone 15' to their wishlist",
      time: "2 minutes ago",
      type: NotificationType.wishlist,
    ),
    NotificationItem(
      title: "Birthday Reminder",
      description: "Alex's birthday is coming up in 3 days!",
      time: "1 hour ago",
      type: NotificationType.birthday,
    ),
    NotificationItem(
      title: "Friend Request",
      description: "Michael wants to be your friend",
      time: "2 hours ago",
      type: NotificationType.friend,
    ),
    NotificationItem(
      title: "Gift Reserved",
      description: "Someone reserved a gift from your wishlist",
      time: "1 day ago",
      type: NotificationType.gift,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _animations = List.generate(
      notifications.length,
      (index) => CurvedAnimation(
        parent: _controller,
        curve: Interval(
          index * 0.1,
          1.0,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<NotificationItem> get filteredNotifications {
    if (_selectedFilter == null) return notifications;
    return notifications.where((n) => n.type == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE5DDFE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF48407D)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: Color(0xFF48407D),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: Color(0xFF48407D)),
            onPressed: () {
              Navigator.pushNamed(context, '/notification_settings');
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
            _buildFilterChips(),
            Expanded(
              child: notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: filteredNotifications.length,
                      padding: EdgeInsets.only(top: 8),
                      itemBuilder: (context, index) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                          ).animate(_animations[index]),
                          child: FadeTransition(
                            opacity: _animations[index],
                            child: _buildNotificationCard(
                              filteredNotifications[index],
                              index,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildFilterChip(null, 'All'),
          SizedBox(width: 8),
          ...NotificationType.values.map((type) {
            return Padding(
              padding: EdgeInsets.only(right: 8),
              child: _buildFilterChip(type, type.name),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(NotificationType? type, String label) {
    final isSelected = _selectedFilter == type;
    return FilterChip(
      selected: isSelected,
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Fredoka',
          color: isSelected ? Colors.white : Color(0xFF48407D),
        ),
      ),
      backgroundColor: Colors.white,
      selectedColor: Color(0xFF48407D),
      checkmarkColor: Colors.white,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? type : null;
        });
      },
    );
  }

  Widget _buildNotificationCard(NotificationItem notification, int index) {
    return Dismissible(
      key: Key('${notification.title}_$index'),
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.red),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Handle notification deletion
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shadowColor: Color(0xFF48407D).withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Handle notification tap
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    notification.type.icon,
                    color: Color(0xFF48407D),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF48407D),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        notification.description,
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 14,
                          color: Color(0xFFA192EA),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        notification.time,
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 12,
                          color: Color(0xFFA192EA).withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: Color(0xFF48407D).withOpacity(0.5),
          ),
          SizedBox(height: 16),
          Text(
            "No notifications yet",
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 24,
              color: Color(0xFF48407D),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "We'll notify you when something happens",
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 16,
              color: Color(0xFFA192EA),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final NotificationType type;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
  });
}

enum NotificationType {
  wishlist(Icons.card_giftcard),
  birthday(Icons.cake),
  friend(Icons.person_add),
  gift(Icons.redeem);

  final IconData icon;
  const NotificationType(this.icon);
}
