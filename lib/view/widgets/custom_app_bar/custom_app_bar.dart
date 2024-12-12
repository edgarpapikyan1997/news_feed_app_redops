import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redops_app/utils/extensions/context_extensions.dart';
import 'package:redops_app/utils/extensions/widget_extensions.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget leadingButton;
  final Widget tealButton;

  const CustomAppBar({
    super.key,
    this.title = '',
    required this.leadingButton,
    required this.tealButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leadingButton,
          Text(title!, style: context.theme.headline5.darkBlue,),
          const SizedBox(),
          tealButton,
        ],
      ).paddingOnly(left: 16, right: 16, top: 87),
    );
  }
}
