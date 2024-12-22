import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/user_store.dart';
import 'package:wishlist_test/pages/calendar.dart';
import 'package:wishlist_test/pages/Friends.dart';
import 'package:wishlist_test/pages/settings.dart';
import 'package:wishlist_test/pages/edit_profile.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with SingleTickerProviderStateMixin {
  final String userCode = "ID: 123456";
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _copyIdToClipboard(BuildContext context) {
    final cleanId = userCode.replaceAll('ID: ', '');
    Clipboard.setData(ClipboardData(text: cleanId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ID copied to clipboard',
          style: TextStyle(
            fontFamily: 'Fredoka',
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF48407D),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(20),
        duration: Duration(seconds: 2),
      ),
    );
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
          "My Profile",
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
            colors: [
              Color(0xFFE5DDFE),
              Color(0xFFF0E4FF).withOpacity(0.5),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.2, 0.5],
          ),
        ),
        child: RefreshIndicator(
          color: Color(0xFF48407D),
          backgroundColor: Colors.white,
          onRefresh: () async {
            // Add refresh logic here
            await Future.delayed(Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Hero(
                            tag: 'profilePic',
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFA192EA),
                                border: Border.all(
                                  color: Color(0xFF48407D),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Consumer<UserStore>(
                                        builder: (context, userStore, child) {
                                          return Text(
                                            userStore.userName,
                                            style: TextStyle(
                                              fontFamily: 'Fredoka',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              color: Color(0xFF48407D),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Color(0xFF48407D)),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfilePage()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => _copyIdToClipboard(context),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE5DDFE),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          userCode,
                                          style: TextStyle(
                                            fontFamily: 'Fredoka',
                                            fontSize: 14,
                                            color: Color(0xFF48407D),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.copy,
                                          size: 16,
                                          color: Color(0xFF48407D),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Статистика
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF48407D).withOpacity(0.1),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildAnimatedStatItem('Friends', 12),
                              _buildAnimatedStatItem('Gifts', 25),
                              _buildAnimatedStatItem('Events', 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Меню опций
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildAnimatedMenuItem(
                        context,
                        "Friends",
                        Icons.group,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FriendsPage()),
                        ),
                      ),
                      _buildAnimatedMenuItem(
                        context,
                        "Calendar",
                        Icons.calendar_today,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarPage()),
                        ),
                      ),
                      _buildAnimatedMenuItem(
                        context,
                        "Settings",
                        Icons.settings,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        ),
                      ),
                      _buildAnimatedMenuItem(
                        context,
                        "Log Out",
                        Icons.exit_to_app,
                        () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "Log Out",
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  color: Color(0xFF48407D),
                                ),
                              ),
                              content: Text(
                                "Are you sure you want to log out?",
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  color: Color(0xFF48407D),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontFamily: 'Fredoka',
                                      color: Color(0xFF48407D),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Логика выхода
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF48407D),
                                  ),
                                  child: Text(
                                    "Log Out",
                                    style: TextStyle(
                                      fontFamily: 'Fredoka',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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

  Widget _buildAnimatedStatItem(String label, int value) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: Duration(seconds: 2),
      builder: (context, value, child) {
        return Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF48407D),
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 14,
                color: Color(0xFFA192EA),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-0.2, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeOutBack),
      )),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            splashColor: Color(0xFF48407D).withOpacity(0.1),
            highlightColor: Color(0xFF48407D).withOpacity(0.05),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF48407D).withOpacity(0.08),
                    blurRadius: 15,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFFE5DDFE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Color(0xFF48407D), size: 24),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF48407D),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFFA192EA),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
