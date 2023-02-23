import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/routes/routes.gr.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    const double iconSize = 30;
    const double textSize = 15;
    Color selectedColor = Theme.of(context).primaryColor;
    return AutoTabsScaffold(
      backgroundColor: AppColors.colorF0F5F9,
      routes: const [
        DashboardRouter(),
        UsersRouter(),
        PostsRouter(),
        NotificationsRouter(),
        SettingsRouter(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return SalomonBottomBar(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              SalomonBottomBarItem(
                selectedColor: selectedColor,
                icon: const Icon(
                  Icons.home_outlined,
                  size: iconSize,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              SalomonBottomBarItem(
                selectedColor: selectedColor,
                icon: const Icon(
                  Icons.person_outlined,
                  size: iconSize,
                ),
                title: const Text(
                  'Users',
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              SalomonBottomBarItem(
                selectedColor: selectedColor,
                icon: const Icon(
                  Icons.post_add_outlined,
                  size: iconSize,
                ),
                title: const Text(
                  'Post',
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              SalomonBottomBarItem(
                selectedColor: selectedColor,
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: iconSize,
                ),
                title: const Text(
                  'Noti',
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              SalomonBottomBarItem(
                selectedColor: selectedColor,
                icon: const Icon(
                  Icons.settings,
                  size: iconSize,
                ),
                title: const Text(
                  'Setting',
                  style: TextStyle(fontSize: textSize),
                ),
              ),
            ]);
      },
    );
  }
}
