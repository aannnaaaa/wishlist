import 'package:flutter/material.dart';

class AddFriendsPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

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
          "Add Friends",
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
        child: Column(
          children: [
            // Поле поиска
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Enter friend's name or ID",
                  hintStyle: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Color(0xFFA192EA),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Color(0xFF48407D)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Кнопка поиска
            ElevatedButton(
              onPressed: () {
                // Логика поиска друзей
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF48407D),
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                "Search",
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Разделитель
            Divider(
              color: Color(0xFFA192EA),
              thickness: 1,
              indent: 30,
              endIndent: 30,
            ),
            // Список результатов поиска
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Предположим, что нашлось 5 друзей
                itemBuilder: (context, index) {
                  return _buildFriendResultCard(
                      context, "Friend $index", "ID: ${1000 + index}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Метод для создания карточки найденного друга
  Widget _buildFriendResultCard(BuildContext context, String name, String id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFFA192EA),
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF48407D),
            ),
          ),
          subtitle: Text(
            id,
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Color(0xFFA192EA),
            ),
          ),
          trailing: ElevatedButton(
            onPressed: () {
              // Логика добавления друга
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF48407D),
              minimumSize: Size(80, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Add",
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
