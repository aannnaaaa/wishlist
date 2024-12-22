// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

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

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Имитация задержки сети
      await Future.delayed(Duration(seconds: 2));

      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/mywishlist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Фоновая картинка
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/background_signin.png',
              fit: BoxFit.cover,
            ),
          ),
          // Основной контент
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 64,
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF48407D),
                        ),
                      ),
                      SizedBox(height: 40),
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
                            borderSide:
                                BorderSide(color: Color(0xFF48407D), width: 2),
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
                            borderSide:
                                BorderSide(color: Color(0xFF48407D), width: 2),
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
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Добавить навигацию на страницу восстановления пароля
                          },
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: Color(0xFF48407D),
                              fontFamily: 'Fredoka_Condensed',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
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
                                  "Sign In",
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
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: 'Fredoka_Condensed',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signup');
                            },
                            child: Text(
                              "Sign Up",
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
