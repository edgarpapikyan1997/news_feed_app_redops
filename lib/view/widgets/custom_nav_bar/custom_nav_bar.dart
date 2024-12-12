import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:redops_app/utils/extensions/extensions.dart';
import '../../../utils/themes/app_colors.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        showSelectedItemShadow: false,
        selectedItemTextStyle: context.theme.headline10,
        barBackgroundColor: AppColors.pureWhite,
        selectedItemBorderColor: AppColors.buttonBlue,
        selectedItemBackgroundColor: AppColors.buttonBlue,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Colors.black,
      ),
      selectedIndex: selectedIndex,
      onSelectTab: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.sunny,
          label: 'main.conditions'.tr(),
        ),
        FFNavigationBarItem(
          iconData: Icons.message,
          label: 'main.feed'.tr(),
        ),
        FFNavigationBarItem(
          iconData: Icons.settings,
          label: 'main.settings'.tr(),
        ),
      ],
    );
  }
}
