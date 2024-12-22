// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Имитация задержки сети
      await Future.delayed(Duration(seconds: 2));

      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/mywishlist');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Фиксируем контент при появлении клавиатуры
      body: Stack(
        children: [
          // Фоновая картинка
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/background_signup.png',
              fit: BoxFit.contain,
            ),
          ),
          // Основной контент
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New",
                        style: TextStyle(
                          fontSize: 64,
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF48407D),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Here?",
                          style: TextStyle(
                            fontSize: 64,
                            fontFamily: 'Fredoka',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF48407D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          validator: _validateName,
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Color(0xFF48407D),
                              fontFamily: 'Fredoka_Condensed',
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF48407D)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF48407D), width: 2),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          validator: _validateEmail,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Color(0xFF48407D),
                              fontFamily: 'Fredoka_Condensed',
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF48407D)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF48407D), width: 2),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        TextFormField(
                          controller: _passwordController,
                          validator: _validatePassword,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Color(0xFF48407D),
                              fontFamily: 'Fredoka_Condensed',
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF48407D)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF48407D), width: 2),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xFF48407D),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE1D4FC),
                              shape: StadiumBorder(),
                              elevation: 4,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF48407D),
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Fredoka_Condensed',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF48407D),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Fredoka_Condensed',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/signin');
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Color(0xFF48407D),
                                  fontFamily: 'Fredoka_Condensed',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
