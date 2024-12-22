import 'package:flutter/material.dart';

class PasswordSettingsPage extends StatefulWidget {
  @override
  _PasswordSettingsPageState createState() => _PasswordSettingsPageState();
}

class _PasswordSettingsPageState extends State<PasswordSettingsPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
          "Password Settings",
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
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPasswordField(
                controller: _currentPasswordController,
                label: "Current Password",
                obscureText: _obscureCurrentPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureCurrentPassword = !_obscureCurrentPassword;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildPasswordField(
                controller: _newPasswordController,
                label: "New Password",
                obscureText: _obscureNewPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildPasswordField(
                controller: _confirmPasswordController,
                label: "Confirm New Password",
                obscureText: _obscureConfirmPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_validatePasswords()) {
                    _showSuccessDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF48407D),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF48407D).withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Color(0xFF48407D),
            fontFamily: 'Fredoka',
          ),
          prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF48407D)),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Color(0xFF48407D),
            ),
            onPressed: onToggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        style: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 16,
          color: Color(0xFF48407D),
        ),
      ),
    );
  }

  bool _validatePasswords() {
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showError("Please fill in all fields");
      return false;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showError("New passwords don't match");
      return false;
    }

    if (_newPasswordController.text.length < 6) {
      _showError("Password must be at least 6 characters long");
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Success",
          style: TextStyle(
            fontFamily: 'Fredoka',
            color: Color(0xFF48407D),
          ),
        ),
        content: Text(
          "Your password has been changed successfully",
          style: TextStyle(
            fontFamily: 'Fredoka',
            color: Color(0xFF48407D),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Закрыть диалог
              Navigator.pop(context); // Вернуться на предыдущий экран
            },
            child: Text(
              "OK",
              style: TextStyle(
                fontFamily: 'Fredoka',
                color: Color(0xFF48407D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
