import 'package:flutter/material.dart';
import 'package:wishlist_test/pages/MyProfilePage.dart';
import 'package:wishlist_test/pages/fullwishlist.dart';
import 'notifications.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_test/models/gift_store.dart';
import 'package:wishlist_test/models/gift.dart';

class MyWishlist extends StatefulWidget {
  @override
  _MyWishlistState createState() => _MyWishlistState();
}

class _MyWishlistState extends State<MyWishlist>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 0.3),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GiftStore>(
      builder: (context, giftStore, child) {
        final gifts = giftStore.gifts;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFE5DDFE),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.person, color: Color(0xFF48407D)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfilePage()),
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications, color: Color(0xFF48407D)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsPage()),
                  );
                },
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE5DDFE), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text(
                    "My Wishlist",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: Color(0xFF48407D),
                    ),
                  ),
                ),
                if (gifts.isEmpty)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add gifts to your wishlist",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Fredoka',
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF48407D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullWishlistPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE1D4FC),
                            minimumSize: Size(260, 70),
                            shape: StadiumBorder(),
                          ),
                          icon: Icon(
                            Icons.card_giftcard,
                            color: Colors.black,
                          ),
                          label: Text(
                            "Add first gift",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Fredoka',
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: gifts.length > 4 ? 4 : gifts.length,
                            itemBuilder: (context, index) {
                              final gift = gifts[index];
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Color(0xFFF0E4FF),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (gift.imageUrl != null)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            gift.imageUrl!,
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      SizedBox(height: 8),
                                      Text(
                                        gift.name,
                                        style: TextStyle(
                                          fontFamily: 'Fredoka',
                                          fontSize: 18,
                                          color: Color(0xFF48407D),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              gift.description,
                                              style: TextStyle(
                                                fontFamily: 'Fredoka',
                                                fontSize: 14,
                                                color: Color(0xFFA192EA),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          _buildPriorityIndicator(
                                              gift.priority),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (gifts.length > 4)
                          SlideTransition(
                            position: _slideAnimation,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              margin: EdgeInsets.only(bottom: 40),
                              decoration: BoxDecoration(
                                color: Color(0xFFF0E4FF),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xFF48407D),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "See all ${gifts.length} gifts",
                                    style: TextStyle(
                                      fontFamily: 'Fredoka',
                                      fontSize: 16,
                                      color: Color(0xFF48407D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullWishlistPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE1D4FC),
                              minimumSize: Size(260, 70),
                              shape: StadiumBorder(),
                            ),
                            icon: Icon(
                              Icons.card_giftcard,
                              color: Colors.black,
                            ),
                            label: Text(
                              gifts.length > 4
                                  ? "Full wishlist"
                                  : "Add more gifts",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Fredoka',
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriorityIndicator(GiftPriority priority) {
    final colors = {
      GiftPriority.low: Color(0xFFA5D6A7), // Light Green
      GiftPriority.medium: Color(0xFFFFCC80), // Light Orange
      GiftPriority.high: Color(0xFFEF9A9A), // Light Red
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors[priority]!,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        priority == GiftPriority.high
            ? Icons.priority_high
            : priority == GiftPriority.medium
                ? Icons.remove
                : Icons.arrow_downward,
        size: 14,
        color: Color(0xFF48407D),
      ),
    );
  }
}
