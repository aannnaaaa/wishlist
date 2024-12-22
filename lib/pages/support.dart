import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? _expandedIndex;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> faqItems = [
    {
      'question': 'How do I add items to my wishlist?',
      'answer':
          'To add items to your wishlist, tap the "+" button on the main screen and fill in the item details. You can add name, description, price, and even an image of the item.',
      'icon': Icons.card_giftcard,
    },
    {
      'question': 'How do I add friends?',
      'answer':
          'You can add friends by going to the Friends page and using the search function to find them by name or ID. Once you find them, just send a friend request and wait for their acceptance.',
      'icon': Icons.people,
    },
    {
      'question': 'Can I make my wishlist private?',
      'answer':
          'Yes, you can control your wishlist privacy in Account Settings > Privacy > Profile Visibility. You can choose to make it visible to all friends, selected friends, or keep it completely private.',
      'icon': Icons.visibility,
    },
    {
      'question': 'How do notifications work?',
      'answer':
          'You\'ll receive notifications for friend requests, upcoming birthdays, wishlist updates from friends, and when someone reserves a gift from your wishlist. You can customize notification settings in the app settings.',
      'icon': Icons.notifications,
    },
    {
      'question': 'How do I edit or delete items?',
      'answer':
          'To edit or delete an item, go to your wishlist and swipe left on the item you want to modify. You\'ll see options to edit or delete the item.',
      'icon': Icons.edit,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredFaqItems {
    if (_searchQuery.isEmpty) return faqItems;
    return faqItems.where((item) {
      return item['question']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          item['answer']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();
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
          "Support",
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
            _buildSearchBar(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildSectionTitle('Frequently Asked Questions'),
                  SizedBox(height: 16),
                  ...filteredFaqItems.asMap().entries.map((entry) {
                    return _buildFAQItem(entry.value, entry.key);
                  }).toList(),
                  SizedBox(height: 24),
                  _buildContactSupport(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF48407D).withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search FAQ',
          hintStyle: TextStyle(
            fontFamily: 'Fredoka',
            color: Color(0xFFA192EA),
          ),
          prefixIcon: Icon(Icons.search, color: Color(0xFF48407D)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Fredoka',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF48407D),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> item, int index) {
    final isExpanded = _expandedIndex == index;
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF48407D).withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              _expandedIndex = isExpanded ? null : index;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F3FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: Color(0xFF48407D),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['question'],
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF48407D),
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Color(0xFF48407D),
                    ),
                  ],
                ),
                if (isExpanded) ...[
                  SizedBox(height: 12),
                  Text(
                    item['answer'],
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 14,
                      color: Color(0xFFA192EA),
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSupport() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Still need help?",
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF48407D),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Contact our support team and we'll help you resolve any issues.",
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 14,
              color: Color(0xFFA192EA),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement contact support action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF48407D),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mail_outline, size: 20),
                SizedBox(width: 8),
                Text(
                  'Contact Support',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 16,
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
