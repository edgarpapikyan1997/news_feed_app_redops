import 'package:flutter/cupertino.dart';
import 'package:redops_app/utils/extensions/context_extensions.dart';
import 'package:redops_app/utils/extensions/widget_extensions.dart';

import '../../../utils/extensions/extensions.dart';
import '../../../utils/themes/app_colors.dart';
import '../custom_button/custom_button.dart';

String getPostedDateTime(DateTime date, {bool numericDates = true}) {
  final DateTime now = DateTime.now();
  final Duration difference = now.difference(date);

  if (difference.inDays > 8) {
    return DateFormat('dd.MM.yyyy | HH:mm').format(date);
  } else if (difference.inDays >= 1) {
    return difference.inDays == 1
        ? (numericDates ? '1 day ago' : 'Yesterday')
        : '${difference.inDays} days ago';
  } else if (difference.inHours >= 1) {
    return difference.inHours == 1
        ? '1 hour ago'
        : '${difference.inHours} hours ago';
  } else if (difference.inMinutes >= 1) {
    return difference.inMinutes == 1
        ? '1 minute ago'
        : '${difference.inMinutes} minutes ago';
  } else {
    return 'just now';
  }
}

Widget TagsWrap(
    {required List<String> tags,
    required BuildContext context,
    required bool showMore}) {
  return Wrap(
    spacing: 8,
    children: tags.map((tag) {
      return CustomButton(
        bordersAllRadius: 12,
        buttonColor: AppColors.buttonTagColor,
        child: Text(tag, style: context.theme.headline6.black).paddingAll(12),
      ).paddingVertical(4);
    }).toList(),
  );
}
