import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/string_constant.dart';
import 'add_library_screen.dart';
import 'add_photo_screen.dart';
import 'add_video_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = <Widget>[
    const AddLibraryScreen(),
    const AddPhotoScreen(),
    const AddVideoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: DimensionConstant.SIZE_27,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorConstant.FF262626,
        unselectedItemColor: ColorConstant.FF969696,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text(
              StringConstant.LIBRARY_LABEL,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: DimensionConstant.SIZE_16,
                  ),
            ),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Text(
              StringConstant.PHOTO_LABEL,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: DimensionConstant.SIZE_16,
                  ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Text(
              StringConstant.VIDEO_LABEL,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: DimensionConstant.SIZE_16,
                  ),
            ),
            label: 'Reels',
          ),
        ],
      ),
    );
  }
}
