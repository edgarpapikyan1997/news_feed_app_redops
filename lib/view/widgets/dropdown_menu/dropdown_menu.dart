import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:redops_app/utils/extensions/context_extensions.dart';
import 'package:redops_app/utils/extensions/widget_extensions.dart';
import 'package:redops_app/utils/themes/app_colors.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key, required this.width});

  final double width;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  bool isButtonOneChosen = true;

  Widget chosenButton({
    required bool isChosen,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(

      onTap: onTap,
      child: Container(
        width: context.width,
        decoration: BoxDecoration(
          color: isChosen ? AppColors.buttonBlue : AppColors.buttonWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 35,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: isChosen
                ? context.theme.headline4.white
                : context.theme.headline7.black,
          ),
        ).paddingOnly(left: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.pureWhite,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: AppColors.darkBlueTextColor.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 0.1,
          ),
        ],
      ),
      alignment: Alignment.center,
      curve: Curves.bounceOut,
      duration: const Duration(milliseconds: 800),
      child: Column(
        children: [
          chosenButton(
            isChosen: isButtonOneChosen,
            title: 'main.viewAll'.tr(),
            onTap: () {
              setState(() {
                isButtonOneChosen = true;
              });
            },
          ),
          const SizedBox(
            height: 8,
          ),
          chosenButton(
            isChosen: !isButtonOneChosen,
            title: 'main.myInterests'.tr(),
            onTap: () {
              setState(() {
                isButtonOneChosen = false;
              });
            },
          ),
        ],
      ).paddingOnly(top: 14, bottom: 16, left: 16, right: 16),
    );
  }
}
