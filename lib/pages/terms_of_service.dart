import 'package:flutter/material.dart';

class TermsOfServicePage extends StatefulWidget {
  @override
  _TermsOfServicePageState createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;
  int _selectedSection = 0;

  final List<Map<String, dynamic>> sections = [
    {
      'title': 'Introduction',
      'icon': Icons.info_outline,
      'content': '''
Welcome to Wishlist App. By using our app, you agree to these terms. Please read them carefully.

This agreement is between you and Wishlist App regarding your use of our services. By using our app, you indicate that you understand and agree to these terms.
'''
    },
    {
      'title': 'Account Terms',
      'icon': Icons.person_outline,
      'content': '''
• You must be 13 years or older to use this service
• You must provide accurate and complete information
• You are responsible for maintaining your account security
• You must notify us of any unauthorized use of your account
'''
    },
    {
      'title': 'Privacy & Data',
      'icon': Icons.security,
      'content': '''
We take your privacy seriously. Our service:
• Collects only necessary information
• Protects your personal data
• Never shares your information without consent
• Allows you to control your data

See our Privacy Policy for more details.
'''
    },
    {
      'title': 'User Guidelines',
      'icon': Icons.rule,
      'content': '''
When using our service, you agree to:
• Respect other users
• Not post inappropriate content
• Not spam or harass others
• Not use the service for illegal activities
• Follow all applicable laws
'''
    },
    {
      'title': 'Content Rules',
      'icon': Icons.content_paste,
      'content': '''
For wishlist content, you must:
• Only post content you have rights to
• Not post offensive or inappropriate items
• Not post misleading information
• Respect intellectual property rights
'''
    },
    {
      'title': 'Termination',
      'icon': Icons.block,
      'content': '''
We may suspend or terminate your account if:
• You violate these terms
• You misuse the service
• You engage in fraudulent activity
• Required by law
'''
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showBackToTop = _scrollController.offset > 200;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    setState(() {
      _selectedSection = index;
    });
    final RenderBox box = context.findRenderObject() as RenderBox;
    final double height = box.size.height;
    _scrollController.animateTo(
      index * height * 0.3,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
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
          "Terms of Service",
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
            _buildSectionTabs(),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16),
                    itemCount: sections.length,
                    itemBuilder: (context, index) {
                      return _buildSection(sections[index], index);
                    },
                  ),
                  if (_showBackToTop)
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: FloatingActionButton(
                        backgroundColor: Color(0xFF48407D),
                        mini: true,
                        child: Icon(Icons.arrow_upward),
                        onPressed: () {
                          _scrollController.animateTo(
                            0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTabs() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => _scrollToSection(index),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: _selectedSection == index
                      ? Color(0xFF48407D)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF48407D),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      sections[index]['icon'] as IconData,
                      size: 18,
                      color: _selectedSection == index
                          ? Colors.white
                          : Color(0xFF48407D),
                    ),
                    SizedBox(width: 8),
                    Text(
                      sections[index]['title'],
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 14,
                        color: _selectedSection == index
                            ? Colors.white
                            : Color(0xFF48407D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF48407D).withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
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
                    section['icon'] as IconData,
                    color: Color(0xFF48407D),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  section['title'],
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF48407D),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              section['content'],
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 14,
                height: 1.6,
                color: Color(0xFFA192EA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
