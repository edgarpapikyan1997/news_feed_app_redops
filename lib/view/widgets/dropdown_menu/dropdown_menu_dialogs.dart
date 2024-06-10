import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:redops_app/utils/extensions/extensions.dart';
import '../../../utils/themes/app_colors.dart';

class DropdownAlertDialog extends StatelessWidget {
  final Widget? icon;
  final String title;
  final Widget button;
  final Widget? button2;

  const DropdownAlertDialog(
      {super.key,
        this.icon,
      required this.title,
      required this.button,
      this.button2});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBlueTextColor2.withOpacity(0.4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon ?? const SizedBox(),
                SizedBox(
                  width: 210,
                    child: Text(title, style: context.theme.headline4.darkBlue, textAlign: TextAlign.center,).paddingVertical(24)),
                button,
                button2 ?? const SizedBox(),
              ],
            ).paddingOnly(left: 32, right: 32, bottom: 24, top: 32),
          ),
        ),
      ),
    );
  }
}
