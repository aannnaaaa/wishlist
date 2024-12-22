import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _pushEnabled = true;
  bool _emailEnabled = true;
  bool _friendRequestEnabled = true;
  bool _giftUpdatesEnabled = true;
  bool _birthdayRemindersEnabled = true;
  bool _wishlistUpdatesEnabled = true;

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
          "Notification Settings",
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: Color(0xFF48407D),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE5DDFE), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("General Notifications"),
                _buildSettingsCard(
                  children: [
                    _buildSwitchItem(
                      "Push Notifications",
                      "Receive push notifications",
                      _pushEnabled,
                      (value) => setState(() => _pushEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchItem(
                      "Email Notifications",
                      "Receive email notifications",
                      _emailEnabled,
                      (value) => setState(() => _emailEnabled = value),
                    ),
                  ],
                ),
                _buildSectionTitle("Social"),
                _buildSettingsCard(
                  children: [
                    _buildSwitchItem(
                      "Friend Requests",
                      "Notifications about new friend requests",
                      _friendRequestEnabled,
                      (value) => setState(() => _friendRequestEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchItem(
                      "Gift Updates",
                      "Updates about gifts from friends",
                      _giftUpdatesEnabled,
                      (value) => setState(() => _giftUpdatesEnabled = value),
                    ),
                  ],
                ),
                _buildSectionTitle("Reminders"),
                _buildSettingsCard(
                  children: [
                    _buildSwitchItem(
                      "Birthday Reminders",
                      "Reminders about friends' birthdays",
                      _birthdayRemindersEnabled,
                      (value) =>
                          setState(() => _birthdayRemindersEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchItem(
                      "Wishlist Updates",
                      "Updates about friends' wishlists",
                      _wishlistUpdatesEnabled,
                      (value) =>
                          setState(() => _wishlistUpdatesEnabled = value),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Fredoka',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF48407D),
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF48407D).withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Fredoka_Condensed',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xFF48407D),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 12,
                    color: Color(0xFFA192EA),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF48407D),
            activeTrackColor: Color(0xFFA192EA),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Color(0xFFE5DDFE),
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
