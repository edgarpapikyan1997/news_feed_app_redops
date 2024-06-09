import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:redops_app/utils/extensions/context_extensions.dart';
import 'package:redops_app/utils/extensions/widget_extensions.dart';

import '../../../utils/themes/app_colors.dart';

class TextDescription extends StatefulWidget {
  final String text;

  const TextDescription({Key? key, required this.text}) : super(key: key);

  @override
  State<TextDescription> createState() => _TextDescriptionState();
}

class _TextDescriptionState extends State<TextDescription> {
  late String firstHalf;
  late String secondHalf;

  late bool flag;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
      flag = true;
    } else {
      firstHalf = widget.text;
      secondHalf = "";
      flag = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(flag ? ("$firstHalf...") : (firstHalf + secondHalf)),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "main.showMore".tr() : "main.showLess".tr(),
                        style: context.theme.headline9.buttonBlue),

                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    ).paddingSymmetric(horizontal:  10, vertical: 10);
  }
}
