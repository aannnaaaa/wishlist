import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_test/models/gift_store.dart';
import 'package:wishlist_test/models/settings_store.dart';
import 'package:wishlist_test/pages/MyWishlist.dart';
import 'package:wishlist_test/pages/fullwishlist.dart';
import 'package:wishlist_test/pages/notification_settings.dart';
import 'package:wishlist_test/pages/signin.dart';
import 'package:wishlist_test/pages/signup.dart';
import 'models/user_store.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserStore()),
        ChangeNotifierProvider(create: (_) => GiftStore()),
        ChangeNotifierProvider(create: (_) => SettingsStore()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(), // Стартовый экран
      routes: {
        '/signin': (context) => SignInPage(), // Маршрут к странице входа
        '/signup': (context) => SignUpPage(), // Маршрут к странице регистрации
        '/mywishlist': (context) =>
            MyWishlist(), // Новый маршрут для страницы MyWishlist
        '/fullwishlist': (context) =>
            FullWishlistPage(), // Добавили маршрут для FullWishlistPage
        '/notification_settings': (context) =>
            NotificationSettingsPage(), // Добавляем новый маршрут
      },
    );
  }
}
