import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFA192EA), // Цвет фона меню
      child: Column(
        children: [
          // Верхняя часть меню с надписью и крестиком для закрытия
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Menu",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Color(0xFF48407D),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Color(0xFF48407D)),
                  onPressed: () {
                    Navigator.of(context).pop(); // Закрыть меню
                  },
                ),
              ],
            ),
          ),
          // Опции меню
          _buildMenuItem(context, "My Profile", Icons.person),
          _buildMenuItem(context, "Friends", Icons.group),
          _buildMenuItem(context, "Calendar", Icons.calendar_today),
          _buildMenuItem(context, "Wallet", Icons.account_balance_wallet),
          _buildMenuItem(context, "Settings", Icons.settings),
          _buildMenuItem(context, "Log Out", Icons.exit_to_app),
        ],
      ),
    );
  }

  // Метод для создания каждой опции меню
  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Color(0xFFFCEDF6)),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Fredoka_Condensed',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color(0xFF48407D),
            ),
          ),
          onTap: () {
            // Действие при нажатии на пункт меню, например:
            Navigator.of(context).pop(); // Закрыть меню
            // Добавьте логику для перехода на другие страницы
          },
        ),
        // Используем Container с градиентом для разделителей
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA192EA), Color(0xFFE7E0FE), Color(0xFFA192EA)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
