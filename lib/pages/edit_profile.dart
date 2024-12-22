import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_store.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  bool _isEdited = false;
  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _userStore = Provider.of<UserStore>(context, listen: false);
    _nameController.text = _userStore.userName;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationController.forward();

    _nameController.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    setState(() {
      _isEdited = _nameController.text != _userStore.userName;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      _userStore.updateUserName(_nameController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile updated successfully!',
            style: TextStyle(fontFamily: 'Fredoka'),
          ),
          backgroundColor: Color(0xFF48407D),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE5DDFE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF48407D)),
          onPressed: () {
            if (_isEdited) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Discard Changes?',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      color: Color(0xFF48407D),
                    ),
                  ),
                  content: Text(
                    'You have unsaved changes. Are you sure you want to leave?',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      color: Color(0xFFA192EA),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Stay',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          color: Color(0xFF48407D),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF48407D),
                      ),
                      child: Text(
                        'Discard',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: Color(0xFF48407D),
          ),
        ),
        actions: [
          if (_isEdited)
            TextButton(
              onPressed: _handleSave,
              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 16,
                  color: Color(0xFF48407D),
                ),
              ),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Hero(
                        tag: 'profilePic',
                        child: Container(
                          width: 120,
                          height: 120,
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
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xFF48407D),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                _buildTextField(
                  controller: _nameController,
                  label: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters long';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: TextStyle(
        fontFamily: 'Fredoka',
        fontSize: 16,
        color: Color(0xFF48407D),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Fredoka',
          color: Color(0xFFA192EA),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFFE5DDFE),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFF48407D),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
