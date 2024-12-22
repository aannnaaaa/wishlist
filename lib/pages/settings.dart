import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../models/settings_store.dart';
import '../models/user_store.dart';
import 'package:wishlist_test/pages/account_settings.dart';
import 'package:wishlist_test/pages/password_settings.dart';
import 'package:wishlist_test/pages/privacy_policy.dart';
import 'package:wishlist_test/pages/support.dart';
import 'package:wishlist_test/pages/terms_of_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _cardAnimations = List.generate(
      3,
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

  Future<void> _exportData() async {
    try {
      final userName = Provider.of<UserStore>(context, listen: false).userName;
      final settingsStore = Provider.of<SettingsStore>(context, listen: false);

      final data = '''
User Data:
Name: $userName

App Settings:
Language: ${settingsStore.language}
Dark Theme: ${settingsStore.isDarkMode ? 'Enabled' : 'Disabled'}
Notifications: ${settingsStore.notificationsEnabled ? 'Enabled' : 'Disabled'}
      ''';

      await Clipboard.setData(ClipboardData(text: data));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data copied to clipboard',
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error exporting data',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  void _showLanguageDialog() {
    final languages = ['English', 'Русский'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Select Language',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFF48407D),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) {
            return ListTile(
              title: Text(
                lang,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF48407D),
                ),
              ),
              onTap: () {
                Provider.of<SettingsStore>(context, listen: false)
                    .setLanguage(lang);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final settingsStore = Provider.of<SettingsStore>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE5DDFE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF48407D)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            fontFamily: 'Roboto',
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
                _buildSectionWithAnimation("Account", 0),
                _buildSectionWithAnimation("Help & Support", 1),
                _buildSectionWithAnimation("App", 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWithAnimation(String title, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 0.2),
        end: Offset.zero,
      ).animate(_cardAnimations[index]),
      child: FadeTransition(
        opacity: _cardAnimations[index],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(title),
            _buildSettingsCard(
              children: _getSettingsItems(title),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getSettingsItems(String section) {
    final settingsStore = Provider.of<SettingsStore>(context);

    switch (section) {
      case "Account":
        return [
          _buildSettingsItem(
            context,
            "Account Settings",
            Icons.person_outline,
            "Manage your account details",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountSettingsPage()),
            ),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            "Password",
            Icons.lock_outline,
            "Change your password",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PasswordSettingsPage()),
            ),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            "Notifications",
            Icons.notifications_outlined,
            settingsStore.notificationsEnabled
                ? "Notifications enabled"
                : "Notifications disabled",
            () => settingsStore.toggleNotifications(),
            trailing: Switch(
              value: settingsStore.notificationsEnabled,
              onChanged: (_) => settingsStore.toggleNotifications(),
              activeColor: Color(0xFF48407D),
            ),
          ),
        ];
      case "Help & Support":
        return [
          _buildSettingsItem(
            context,
            "Privacy Policy",
            Icons.privacy_tip_outlined,
            "Read our privacy policy",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
            ),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            "Terms of Service",
            Icons.description_outlined,
            "Read our terms of service",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TermsOfServicePage()),
            ),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            "Support",
            Icons.help_outline,
            "Get help and support",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportPage()),
            ),
          ),
        ];
      case "App":
        return [
          _buildSettingsItem(
            context,
            "Dark Theme",
            Icons.dark_mode_outlined,
            settingsStore.isDarkMode
                ? "Dark theme enabled"
                : "Dark theme disabled",
            () => settingsStore.toggleDarkMode(),
            trailing: Switch(
              value: settingsStore.isDarkMode,
              onChanged: (_) => settingsStore.toggleDarkMode(),
              activeColor: Color(0xFF48407D),
            ),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            "Language",
            Icons.translate,
            "Current language: ${settingsStore.language}",
            _showLanguageDialog,
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            "Export Data",
            Icons.download_outlined,
            "Save your data",
            _exportData,
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            "About",
            Icons.info_outline,
            "Version and information",
            () => _showAboutDialog(context),
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF48407D).withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
    VoidCallback onTap, {
    Widget? trailing,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Color(0xFF48407D).withOpacity(0.1),
        highlightColor: Color(0xFF48407D).withOpacity(0.05),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF48407D),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        color: Color(0xFFA192EA),
                      ),
                    ),
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xFFA192EA),
                    size: 20,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Color(0xFFE5DDFE),
      thickness: 1,
      height: 1,
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "About App",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFF48407D),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Version: 1.0.0",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF48407D),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "A wishlist app to help you organize gifts and celebrations.",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF48407D),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Made with ❤️",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF48407D),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF48407D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
