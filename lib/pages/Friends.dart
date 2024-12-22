import 'package:flutter/material.dart';
import 'package:wishlist_test/pages/add_friends.dart';
import 'package:wishlist_test/pages/friends_wishlist.dart';

class FriendsPage extends StatefulWidget {
  final List<Map<String, String>> friends = [
    {"name": "Alice", "id": "1234"},
    {"name": "Bob", "id": "5678"},
    {"name": "Charlie", "id": "9101"},
    {"name": "Daisy", "id": "1121"},
    {"name": "Eve", "id": "3141"},
  ];

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredFriends = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
    _filteredFriends = widget.friends;
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterFriends(String query) {
    setState(() {
      _filteredFriends = widget.friends
          .where((friend) =>
              friend['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final refreshIndicator = RefreshIndicator(
      color: Color(0xFF48407D),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF48407D).withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterFriends,
                decoration: InputDecoration(
                  hintText: "Search friends...",
                  hintStyle: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Color(0xFFA192EA),
                  ),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF48407D)),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredFriends.length,
              itemBuilder: (context, index) {
                final animation = CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    (index / _filteredFriends.length) * 0.5,
                    ((index + 1) / _filteredFriends.length) * 0.5,
                    curve: Curves.easeOut,
                  ),
                );
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: _buildFriendCard(
                      context,
                      _filteredFriends[index]['name']!,
                      _filteredFriends[index]['id']!,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

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
        title: Row(
          children: [
            Text(
              "Friends",
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: Color(0xFF48407D),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFE1D4FC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${widget.friends.length}",
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 16,
                  color: Color(0xFF48407D),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5DDFE),
              Color(0xFFF0E4FF).withOpacity(0.5),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.2, 0.5],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: refreshIndicator,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF48407D).withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddFriendsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF48407D),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                icon: Icon(Icons.person_add, color: Colors.white),
                label: Text(
                  "Add Friends",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendCard(BuildContext context, String name, String id) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendDetailsPage(name: name, id: id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF48407D).withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'avatar_$id',
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFFA192EA),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Fredoka_Condensed',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF48407D),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "ID: $id",
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 14,
                  color: Color(0xFFA192EA),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF48407D), Color(0xFF5D4E9D)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FriendDetailsPage(name: name, id: id),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(120, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "View Wishlist",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
