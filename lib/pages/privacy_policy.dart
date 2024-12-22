import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
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
          "Privacy Policy",
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
              _buildSection(
                "Introduction",
                "Welcome to our Privacy Policy. This document explains how we collect, use, and protect your personal information when you use our application.",
              ),
              _buildSection(
                "Information We Collect",
                "• Personal Information (name, email, phone number)\n"
                    "• Profile Information\n"
                    "• Usage Data\n"
                    "• Device Information",
              ),
              _buildSection(
                "How We Use Your Information",
                "• To provide and maintain our service\n"
                    "• To notify you about changes\n"
                    "• To provide customer support\n"
                    "• To detect and prevent fraud",
              ),
              _buildSection(
                "Data Security",
                "We implement appropriate security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction.",
              ),
              _buildSection(
                "Your Rights",
                "• Access your personal data\n"
                    "• Correct your personal data\n"
                    "• Delete your account\n"
                    "• Object to processing\n"
                    "• Data portability",
              ),
              _buildSection(
                "Contact Us",
                "If you have any questions about this Privacy Policy, please contact us at support@wishlist.com",
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Last updated: March 2024",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 14,
                    color: Color(0xFFA192EA),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF48407D),
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 16,
              color: Color(0xFF48407D),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
