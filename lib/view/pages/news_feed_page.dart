import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redops_app/models/post_model/post_model.dart';
import 'package:redops_app/presenter/bloc/post_bloc/post_bloc.dart';
import 'package:redops_app/utils/extensions/extensions.dart';
import 'package:redops_app/view/widgets/custom_nav_bar/custom_nav_bar.dart';
import '../../utils/assets.dart';
import '../../utils/themes/app_colors.dart';
import '../widgets/custom_app_bar/custom_app_bar.dart';
import '../widgets/dropdown_menu/dropdown_menu.dart';
import '../widgets/post_item/post_item.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  final ScrollController _scrollController = ScrollController();
  bool _hasReachedMax = false;
  bool isOpened = false;
  double containerWidth = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<PostBloc>(context)
        .add(const LoadPostEvent(count: 5, startIndex: 0, favorites: false));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final postBloc = BlocProvider.of<PostBloc>(context);
      if (postBloc.state is PostLoadedState) {
        final currentState = postBloc.state as PostLoadedState;
        if (!currentState.hasReachedMax) {
          postBloc.add(LoadPostEvent(
              count: 5,
              startIndex: currentState.posts.length,
              favorites: false));
        } else if (!_hasReachedMax) {
          _showNoMoreDataNotification();
          _hasReachedMax = true;
        }
      }
    }
  }

  void _showNoMoreDataNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No more data'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void checkForAnyAlert({required List<PostModel> postModels}) {
    List<PostModel> oldPostModel = postModels;
    for (var i = 0; i < postModels.length; ++i) {
      if (postModels[i].alert != null) {
        postModels.move(i, 0);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteBackground,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size(0, 87),
          child: CustomAppBar(
            leadingButton: GestureDetector(
              onTap: () {
                setState(() {
                  isOpened = !isOpened;
                  containerWidth = isOpened ? 234 : 0;
                });
              },
              child: Row(
                children: [
                  Text(
                    'main.viewAll'.tr(),
                    style: context.theme.headline6.darkBlue,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(Assets.arrowDown),
                  ),
                ],
              ),
            ),
            title: 'main.insiderFeed'.tr(),
            tealButton: Image.asset(Assets.signalIcon),
          ),
        ),
        bottomNavigationBar: const CustomNavBar(),
        body: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
          if (state is PostLoadingState && state is! PostLoadedState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is PostErrorState) {
            return const Center(child: Text("Error Something went wrong!!!"));
          }
          if (state is PostLoadedState) {
            List<PostModel> postDataList = state.posts;
            checkForAnyAlert(postModels: postDataList);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isOpened) {
                    containerWidth = 0;
                  }
                });
              },
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: ColoredBox(
                          color: AppColors.darkBlueTextColor.withOpacity(0.1),
                          child: SizedBox(
                            height: 0.5,
                            width: context.width,
                          ),
                        ).paddingOnly(top: 16),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index >= postDataList.length) {
                              return state.hasReachedMax
                                  ? Container()
                                  : const Center(
                                      child: CupertinoActivityIndicator(),
                                    );
                            }
                            PostModel postModel = postDataList[index];
                            return PostItem(
                              postModel: postModel,
                            );
                          },
                          childCount: postDataList.length + 1,
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 55),
                  Positioned(
                      top: 4,
                      left: 20,
                      child: DropDownMenu(
                        width: containerWidth,
                      )),
                ],
              ),
            );
          }
          return SizedBox(child: Text('main.somethingWentWrong'.tr()));
        }),
      ),
    );
  }
}
