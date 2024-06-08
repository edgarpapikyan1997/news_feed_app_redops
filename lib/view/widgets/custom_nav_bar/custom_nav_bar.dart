import 'package:flutter/material.dart';

import '../../../utils/themes/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: AppColors.backGroundColorLight,
        items: [
          bottomNavBarItem(icon: Icon(Icons.home), label: 'Home'),
          bottomNavBarItem(icon: Icon(Icons.chat), label: 'Feed'),
          bottomNavBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ]);
  }
}

BottomNavigationBarItem bottomNavBarItem(
    {required Icon icon,
    required String label,}) {
  return BottomNavigationBarItem(
      icon: icon, label: label,);
}
