import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_test/models/gift_store.dart';
import 'package:wishlist_test/models/gift.dart';

class FullWishlistPage extends StatefulWidget {
  @override
  _FullWishlistPageState createState() => _FullWishlistPageState();
}

class _FullWishlistPageState extends State<FullWishlistPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller.forward();
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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFE5DDFE),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF48407D)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              children: [
                Text(
                  "Full Wishlist",
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
                    "${giftStore.gifts.length}",
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
                colors: [Color(0xFFE5DDFE), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                if (giftStore.gifts.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.card_giftcard,
                            size: 80,
                            color: Color(0xFF48407D).withOpacity(0.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Time to add new gifts!",
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Fredoka_Condensed',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF48407D).withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 32),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _showAddGiftDialog(context);
                              },
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE1D4FC),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF48407D).withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add_circle,
                                      size: 28,
                                      color: Color(0xFF48407D),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "Add First Gift",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Fredoka',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF48407D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: giftStore.gifts.length,
                      itemBuilder: (context, index) {
                        final animation = CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            (index / giftStore.gifts.length) * 0.5,
                            ((index + 1) / giftStore.gifts.length) * 0.5,
                            curve: Curves.easeOut,
                          ),
                        );
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: animation.value,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 24),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF0E4FF),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20)),
                                                child: giftStore.gifts[index]
                                                            .imageUrl !=
                                                        null
                                                    ? Image.network(
                                                        giftStore.gifts[index]
                                                            .imageUrl!,
                                                        height: 200,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Container(
                                                        height: 200,
                                                        width: double.infinity,
                                                        color:
                                                            Color(0xFFE5DDFE),
                                                        child: Icon(
                                                          Icons.card_giftcard,
                                                          color:
                                                              Color(0xFF48407D),
                                                          size: 80,
                                                        ),
                                                      ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(Icons.edit,
                                                            color: Color(
                                                                0xFF48407D)),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          _showEditGiftDialog(
                                                              context,
                                                              giftStore.gifts[
                                                                  index]);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(Icons.delete,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  "Delete Gift",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Fredoka',
                                                                    color: Color(
                                                                        0xFF48407D),
                                                                  ),
                                                                ),
                                                                content: Text(
                                                                  "Are you sure you want to delete this gift?",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Fredoka',
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Fredoka',
                                                                        color: Color(
                                                                            0xFF48407D),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                  ElevatedButton(
                                                                    child: Text(
                                                                      "Delete",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Fredoka',
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      giftStore.removeGift(
                                                                          giftStore
                                                                              .gifts[index]);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        giftStore
                                                            .gifts[index].name,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Fredoka_Condensed',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 24,
                                                          color:
                                                              Color(0xFF48407D),
                                                        ),
                                                      ),
                                                    ),
                                                    _buildPriorityIndicator(
                                                        giftStore.gifts[index]
                                                            .priority),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  giftStore
                                                      .gifts[index].description,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Fredoka_Condensed',
                                                    fontSize: 16,
                                                    color: Color(0xFF48407D),
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
                                barrierColor: Colors.black.withOpacity(0.5),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: Color(0xFFF0E4FF),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    child: giftStore.gifts[index].imageUrl !=
                                            null
                                        ? Image.network(
                                            giftStore.gifts[index].imageUrl!,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            height: 120,
                                            color: Color(0xFFE5DDFE),
                                            child: Icon(
                                              Icons.card_giftcard,
                                              color: Color(0xFF48407D),
                                              size: 50,
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                giftStore.gifts[index].name,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Fredoka_Condensed',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Color(0xFF48407D),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            _buildPriorityIndicator(giftStore
                                                .gifts[index].priority),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          giftStore.gifts[index].description,
                                          style: TextStyle(
                                            fontFamily: 'Fredoka_Condensed',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Color(0xFF48407D),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: giftStore.gifts.isNotEmpty
              ? FloatingActionButton.extended(
                  onPressed: () {
                    _showAddGiftDialog(context);
                  },
                  backgroundColor: Color(0xFFE1D4FC),
                  elevation: 4,
                  icon: Icon(Icons.add, color: Color(0xFF48407D)),
                  label: Text(
                    "Add Gift",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      color: Color(0xFF48407D),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  void _showAddGiftDialog(BuildContext context) {
    String giftName = "";
    String giftDescription = "";
    String? imageUrl;
    String? link;
    GiftPriority selectedPriority = GiftPriority.medium;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add a new gift",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF48407D),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0E4FF),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color(0xFF48407D).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              imageUrl = "https://via.placeholder.com/150";
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 40,
                                color: Color(0xFF48407D),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Add Photo",
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  color: Color(0xFF48407D),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0E4FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            giftName = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Gift name",
                            hintStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              color: Color(0xFFA192EA),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0E4FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            giftDescription = value;
                          },
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              color: Color(0xFFA192EA),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0E4FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            link = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Link to gift (optional)",
                            hintStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              color: Color(0xFFA192EA),
                            ),
                            prefixIcon: Icon(
                              Icons.link,
                              color: Color(0xFF48407D),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Priority",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 16,
                          color: Color(0xFF48407D),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: GiftPriority.values.map((priority) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPriority = priority;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: selectedPriority == priority
                                      ? _getPriorityColor(priority)
                                      : _getPriorityColor(priority)
                                          .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                  border: selectedPriority == priority
                                      ? Border.all(
                                          color: Color(0xFF48407D), width: 2)
                                      : null,
                                ),
                                child: Text(
                                  priority.name.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontSize: 14,
                                    fontWeight: selectedPriority == priority
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Color(0xFF48407D),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                color: Color(0xFF48407D),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF48407D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (giftName.isNotEmpty) {
                                final gift = Gift(
                                  name: giftName,
                                  description: giftDescription.isEmpty
                                      ? "No description"
                                      : giftDescription,
                                  imageUrl: imageUrl,
                                  link: link,
                                  priority: selectedPriority,
                                );
                                context.read<GiftStore>().addGift(gift);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getPriorityColor(GiftPriority priority) {
    switch (priority) {
      case GiftPriority.low:
        return Color(0xFFA5D6A7);
      case GiftPriority.medium:
        return Color(0xFFFFCC80);
      case GiftPriority.high:
        return Color(0xFFEF9A9A);
    }
  }

  Widget _buildPriorityIndicator(GiftPriority priority) {
    final colors = {
      GiftPriority.low: Color(0xFFA5D6A7), // Light Green
      GiftPriority.medium: Color(0xFFFFCC80), // Light Orange
      GiftPriority.high: Color(0xFFEF9A9A), // Light Red
    };

    final labels = {
      GiftPriority.low: "Low",
      GiftPriority.medium: "Medium",
      GiftPriority.high: "High",
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors[priority]!,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        labels[priority]!,
        style: TextStyle(
          fontFamily: 'Fredoka_Condensed',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF48407D),
        ),
      ),
    );
  }

  void _showEditGiftDialog(BuildContext context, Gift gift) {
    String giftName = gift.name;
    String giftDescription = gift.description;
    String? imageUrl = gift.imageUrl;
    String? link = gift.link;
    GiftPriority selectedPriority = gift.priority;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit gift",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF48407D),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0E4FF),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color(0xFF48407D).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              imageUrl = "https://via.placeholder.com/150";
                            });
                          },
                          child: imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        imageUrl!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        color: Colors.black.withOpacity(0.3),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 40,
                                      color: Color(0xFF48407D),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Add Photo",
                                      style: TextStyle(
                                        fontFamily: 'Fredoka',
                                        color: Color(0xFF48407D),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0E4FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: TextEditingController(text: giftName),
                          onChanged: (value) {
                            giftName = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Gift name",
                            hintStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              color: Color(0xFFA192EA),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0E4FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller:
                              TextEditingController(text: giftDescription),
                          onChanged: (value) {
                            giftDescription = value;
                          },
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              color: Color(0xFFA192EA),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0E4FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: TextEditingController(text: link),
                          onChanged: (value) {
                            link = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Link to gift (optional)",
                            hintStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              color: Color(0xFFA192EA),
                            ),
                            prefixIcon: Icon(
                              Icons.link,
                              color: Color(0xFF48407D),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Priority",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 16,
                          color: Color(0xFF48407D),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: GiftPriority.values.map((priority) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPriority = priority;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: selectedPriority == priority
                                      ? _getPriorityColor(priority)
                                      : _getPriorityColor(priority)
                                          .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                  border: selectedPriority == priority
                                      ? Border.all(
                                          color: Color(0xFF48407D), width: 2)
                                      : null,
                                ),
                                child: Text(
                                  priority.name.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontSize: 14,
                                    fontWeight: selectedPriority == priority
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Color(0xFF48407D),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                color: Color(0xFF48407D),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF48407D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (giftName.isNotEmpty) {
                                final updatedGift = Gift(
                                  name: giftName,
                                  description: giftDescription.isEmpty
                                      ? "No description"
                                      : giftDescription,
                                  imageUrl: imageUrl,
                                  link: link,
                                  priority: selectedPriority,
                                );
                                final index = context
                                    .read<GiftStore>()
                                    .gifts
                                    .indexOf(gift);
                                if (index != -1) {
                                  context
                                      .read<GiftStore>()
                                      .updateGift(index, updatedGift);
                                }
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
