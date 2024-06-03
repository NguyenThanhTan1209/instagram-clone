import 'package:flutter/material.dart';

import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import 'explore_screen.dart';
import 'home_feed_screen.dart';
import 'post_screen.dart';
import 'reel_screen.dart';
import 'user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  final List<Widget> _screens = <Widget>[
    const HomeFeedScreen(),
    const ExploreScreen(),
    const PostScreen(),
    const ReelScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: DimensionConstant.SIZE_27,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              PathConstant.HOME_FEED_ROUNDED_ICON_PATH,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PathConstant.EXPLORE_ROUNDED_ICON_PATH,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PathConstant.REELS_ROUNED_ICON_PATH,
            ),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PathConstant.NOTIFICATION_ROUNDED_ICON_PATH,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PathConstant.USER_PROFILE_ROUNED_ICON_PATH,
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
