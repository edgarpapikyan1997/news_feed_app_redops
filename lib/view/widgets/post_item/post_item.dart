import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redops_app/utils/extensions/context_extensions.dart';
import 'package:redops_app/utils/extensions/widget_extensions.dart';
import 'package:redops_app/view/widgets/post_item/post_item_methods.dart';
import 'package:redops_app/view/widgets/text_decription/text_description.dart';
import '../../../models/post_model/post_model.dart';
import '../../../utils/assets.dart';
import '../../../utils/themes/app_colors.dart';
import '../custom_button/custom_button.dart';

class PostItem extends StatefulWidget {
  final PostModel postModel;

  const PostItem({required this.postModel, super.key});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool getAllTags = false;
  int tagsCharLength = 0;

  Widget getTagsWrap({
    required BuildContext context,
    required List<String> tags,
    required bool getAllTags,
  }) {
    String characters = '';
    List<Widget> tagItems = [];
    for (var i = 0; i < tags.length; ++i) {
      characters += tags[i];
      tagItems.add(
        CustomButton(
          bordersAllRadius: 12,
          buttonColor: AppColors.buttonTagColor,
          child: Text(tags[i], style: context.theme.headline6.black)
              .paddingAll(12),
        ).paddingVertical(4),
      );
      if (characters.length >= 50 && !getAllTags) {
        tagsCharLength = characters.length;
        return Wrap(
          spacing: 8,
          children: tagItems,
        );
      }
    }
    return Wrap(
      spacing: 8,
      children: tagItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime postDate = DateTime.parse(widget.postModel.postDate);
    return ListTile(
      title: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(widget.postModel.avatar ?? ''),
              ).paddingOnly(right: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.postModel.name} | ${widget.postModel.dep}',
                      style: context.theme.headline6.darkBlue),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(getPostedDateTime(postDate),
                        style: context.theme.headline6.black),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Image(
                  image: AssetImage(Assets.editDots),
                ),
              )
            ],
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTagsWrap(
              context: context,
              tags: widget.postModel.tags,
              getAllTags: getAllTags),
          GestureDetector(
            onTap: () {
              setState(() {
                getAllTags = !getAllTags;
              });
            },
            child: tagsCharLength > 50
                ? Text(
                    getAllTags ? 'main.showLess'.tr() : 'main.showMore'.tr(),
                    style: context.theme.headline9.buttonBlue,
                  )
                : const SizedBox(),
          ),
          widget.postModel.alert != null
              ? CustomButton(
                  bordersAllRadius: 9,
                  buttonColor: AppColors.alertRed3,
                  child: Text(
                    'main.alert'.tr(),
                    style: context.theme.headline6.alertRed,
                  ).paddingSymmetric(vertical: 12, horizontal: 36),
                ).paddingVertical(16)
              : const SizedBox(),
          TextDescription(
            text: widget.postModel.description,
          ),
          if (widget.postModel.image != null)
            Image(
              image: AssetImage(widget.postModel.image!),
            ),
          ColoredBox(
            color: AppColors.darkBlueTextColor.withOpacity(0.1),
            child: SizedBox(
              height: 0.5,
              width: context.width,
            ),
          ),
        ],
      ).paddingOnly(top: 8),
    ).paddingOnly(top: 10);
  }
}
