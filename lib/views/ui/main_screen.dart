import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valenki/controllers/main_screen_provider.dart';
import 'package:valenki/views/ui/cart.dart';
import 'package:valenki/views/ui/favorites.dart';
import 'package:valenki/views/ui/home_page.dart';
import 'package:valenki/views/ui/profile.dart';
import 'package:valenki/views/ui/search.dart';
import '../shared/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const Favourites(),
    CartPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifer>(
      builder: (context, mainScreenNotifer, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifer.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
