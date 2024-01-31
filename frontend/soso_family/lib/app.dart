import 'package:flutter/material.dart';

import 'home.dart';
// import 'login.dart';
// import 'signup.dart';
// import 'search.dart';
// import 'detail.dart';
// import 'mypage.dart';

class SosoFamilyApp extends StatelessWidget {
  const SosoFamilyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Product> productList;
    return MaterialApp(
      title: 'sosofamily',
      initialRoute: '/',
      routes: {
        // '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
        // '/signup': (BuildContext context) => const SignupPage(),
        // '/search': (BuildContext context) => const SearchPage(),
        // '/mypage': (BuildContext context) => const MypagePage(),
        // '/favoriteHotels': (BuildContext context) => FavoriteHotelsPage(),
        // '/detail': (BuildContext context) => DetailPage(),
      },
    );
  }
}
