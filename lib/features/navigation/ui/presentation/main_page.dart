import 'package:flutter/material.dart';
import 'package:home1/features/favorite/ui/presentation/favorite_page.dart';
import 'package:home1/features/news/ui/presentation/home_page.dart';
import 'package:home1/features/profile/ui/presentation/profile_page.dart';
import 'package:home1/features/navigation/ui/widgets/app_bottom_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  static const _pages = [
    HomePage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}