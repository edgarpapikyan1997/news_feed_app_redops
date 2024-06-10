import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:redops_app/models/post_model/post_model.dart';
import 'package:redops_app/utils/extensions/context_extensions.dart';
import 'package:redops_app/utils/extensions/widget_extensions.dart';
import 'package:redops_app/utils/themes/app_colors.dart';
import 'package:redops_app/view/widgets/custom_button/custom_button.dart';

import '../../../utils/assets.dart';
import 'dropdown_menu_dialogs.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu(
      {super.key,
      required this.width,
      this.height,
      required this.optionCount,
     });

  final double width;
  final double? height;
  final int optionCount;

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

  void _showDropdownAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DropdownAlertDialog(
                icon: Image.asset(Assets.warning),
                title: 'main.areYouSure'.tr(),
                button: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DropdownAlertDialog(
                            icon: Image.asset(Assets.vector),
                            title: 'main.postReported'.tr(),
                            button: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CustomButton(
                                height: 54,
                                width: 356,
                                buttonColor: AppColors.darkBlueTextColor,
                                child: Center(
                                  child: Text(
                                    'main.yes'.tr(),
                                    style: context.theme.headline4,
                                  ),
                                ),
                              ).paddingOnly(bottom: 16),
                            ),
                          );
                        });
                  },
                  child: CustomButton(
                    makeBorder: true,
                    borderColor: AppColors.alertRed2,
                    height: 54,
                    width: 356,
                    buttonColor: AppColors.buttonWhite2,
                    child: Center(
                      child: Text(
                        'main.yes'.tr(),
                        style: context.theme.headline4.alertRed2,
                      ),
                    ),
                  ).paddingOnly(bottom: 16),
                ),
                button2: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomButton(
                    height: 54,
                    width: 356,
                    buttonColor: AppColors.darkBlueTextColor,
                    child: Center(
                      child: Text(
                        'main.noGoBack'.tr(),
                        style: context.theme.headline4.white,
                      ),
                    ),
                  ).paddingOnly(bottom: 16),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.optionCount == 1
            ? AppColors.buttonWhite
            : AppColors.pureWhite,
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
      duration: const Duration(milliseconds: 200),
      child: widget.optionCount <= 1
          ? Column(
              children: [
                chosenButton(
                    isChosen: false,
                    title: 'main.report'.tr(),
                    onTap:_showDropdownAlertDialog,
                    ).paddingOnly(bottom: 8),
                chosenButton(
                  isChosen: false,
                  title: 'main.addToFav'.tr(),
                  onTap: _showDropdownAlertDialog,
                ).paddingOnly(bottom: 8),
              ],
            )
          : Column(
              children: [
                chosenButton(
                  isChosen: isButtonOneChosen,
                  title: 'main.viewAll'.tr(),
                  onTap: () {
                    setState(() {
                      isButtonOneChosen = true;
                    });
                  },
                ).paddingOnly(bottom: 8),
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
