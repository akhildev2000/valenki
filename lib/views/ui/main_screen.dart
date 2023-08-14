import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valenki/controllers/main_screen_provider.dart';
import 'package:valenki/views/ui/cart_page.dart';
import 'package:valenki/views/ui/home_page.dart';
import 'package:valenki/views/ui/profile.dart';
import 'package:valenki/views/ui/search.dart';
import '../shared/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  final List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifer>(
      builder: (context, mainScreenNotifer, child) {
        return Scaffold(
          body: pageList[mainScreenNotifer.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
