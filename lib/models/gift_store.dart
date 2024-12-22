import 'package:flutter/foundation.dart';
import 'package:wishlist_test/models/gift.dart';

class GiftStore extends ChangeNotifier {
  final List<Gift> _gifts = [];

  List<Gift> get gifts => _gifts;

  void addGift(Gift gift) {
    _gifts.add(gift);
    notifyListeners();
  }

  void removeGift(Gift gift) {
    _gifts.remove(gift);
    notifyListeners();
  }

  void updateGift(int index, Gift newGift) {
    if (index >= 0 && index < _gifts.length) {
      _gifts[index] = newGift;
      notifyListeners();
    }
  }
}
