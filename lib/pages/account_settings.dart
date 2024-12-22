import 'package:flutter/material.dart';
import 'package:wishlist_test/pages/edit_profile.dart';

class AccountSettingsPage extends StatelessWidget {
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
          "Account Settings",
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
                _buildSectionTitle("Profile"),
                _buildSettingsCard(
                  children: [
                    _buildSettingsItem(
                      context,
                      "Edit Profile",
                      Icons.person_outline,
                      "Change your name and photo",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      context,
                      "Change Email",
                      Icons.email_outlined,
                      "Update your email address",
                      () {
                        _showChangeEmailDialog(context);
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      context,
                      "Change Phone Number",
                      Icons.phone_outlined,
                      "Update your phone number",
                      () {
                        _showChangePhoneDialog(context);
                      },
                    ),
                  ],
                ),
                _buildSectionTitle("Privacy"),
                _buildSettingsCard(
                  children: [
                    _buildSettingsItem(
                      context,
                      "Profile Visibility",
                      Icons.visibility_outlined,
                      "Control who can see your profile",
                      () {
                        // Логика настройки видимости профиля
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      context,
                      "Blocked Users",
                      Icons.block_outlined,
                      "Manage blocked users",
                      () {
                        // Логика управления заблокированными пользователями
                      },
                    ),
                  ],
                ),
                _buildSectionTitle("Account Actions"),
                _buildSettingsCard(
                  children: [
                    _buildSettingsItem(
                      context,
                      "Delete Account",
                      Icons.delete_outline,
                      "Permanently delete your account",
                      () {
                        _showDeleteAccountDialog(context);
                      },
                      isDestructive: true,
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

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isDestructive ? Colors.red.withOpacity(0.1) : Color(0xFFE5DDFE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isDestructive ? Colors.red : Color(0xFF48407D),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 16,
          color: isDestructive ? Colors.red : Color(0xFF48407D),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 12,
          color:
              isDestructive ? Colors.red.withOpacity(0.7) : Color(0xFFA192EA),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: isDestructive ? Colors.red.withOpacity(0.7) : Color(0xFFA192EA),
        size: 16,
      ),
      onTap: onTap,
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

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Delete Account",
          style: TextStyle(
            fontFamily: 'Fredoka',
            color: Colors.red,
          ),
        ),
        content: Text(
          "Are you sure you want to delete your account? This action cannot be undone.",
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
              // Логика удаления аккаунта
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              "Delete",
              style: TextStyle(
                fontFamily: 'Fredoka',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangeEmailDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Change Email",
          style: TextStyle(
            fontFamily: 'Fredoka',
            color: Color(0xFF48407D),
          ),
        ),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Enter new email",
            hintStyle: TextStyle(
              fontFamily: 'Fredoka',
              color: Color(0xFFA192EA),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF48407D)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF48407D)),
            ),
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
              // Логика изменения email
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF48407D),
            ),
            child: Text(
              "Save",
              style: TextStyle(
                fontFamily: 'Fredoka',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePhoneDialog(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Change Phone Number",
          style: TextStyle(
            fontFamily: 'Fredoka',
            color: Color(0xFF48407D),
          ),
        ),
        content: TextField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: "Enter new phone number",
            hintStyle: TextStyle(
              fontFamily: 'Fredoka',
              color: Color(0xFFA192EA),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF48407D)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF48407D)),
            ),
          ),
          keyboardType: TextInputType.phone,
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
              // Логика изменения номера телефона
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF48407D),
            ),
            child: Text(
              "Save",
              style: TextStyle(
                fontFamily: 'Fredoka',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
