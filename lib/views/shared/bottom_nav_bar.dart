import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:valenki/controllers/main_screen_provider.dart';
import 'package:valenki/views/shared/bottom_nav.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifer>(
      builder: (context, mainScreenNotifer, child) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNav(
                  icon: mainScreenNotifer.pageIndex == 0
                      ? Ionicons.home
                      : Ionicons.home_outline,
                  onTap: () {
                    mainScreenNotifer.pageIndex = 0;
                  },
                ),
                BottomNav(
                  icon: mainScreenNotifer.pageIndex == 1
                      ? Ionicons.search
                      : Ionicons.search,
                  onTap: () {
                    mainScreenNotifer.pageIndex = 1;
                  },
                ),
                BottomNav(
                    onTap: () {
                      mainScreenNotifer.pageIndex = 2;
                    },
                    icon: mainScreenNotifer.pageIndex == 2
                        ? Ionicons.heart
                        : Ionicons.heart_outline),
                BottomNav(
                  onTap: () {
                    mainScreenNotifer.pageIndex = 3;
                  },
                  icon: mainScreenNotifer.pageIndex == 3
                      ? Ionicons.cart
                      : Ionicons.cart_outline,
                ),
                BottomNav(
                  onTap: () {
                    mainScreenNotifer.pageIndex = 4;
                  },
                  icon: mainScreenNotifer.pageIndex == 4
                      ? Ionicons.person
                      : Ionicons.person_outline,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
