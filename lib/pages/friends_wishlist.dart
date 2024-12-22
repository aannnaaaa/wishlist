import 'package:flutter/material.dart';

// Страница деталей друга
class FriendDetailsPage extends StatelessWidget {
  final String name;
  final String id;

  FriendDetailsPage({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE5DDFE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF48407D)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Friend's Wishlist",
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: Color(0xFF48407D),
          ),
        ),
      ),
      body: Center(
        child: Text(
          "This is $name's Wishlist (ID: $id)",
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 20,
            color: Color(0xFF48407D),
          ),
        ),
      ),
    );
  }
}
