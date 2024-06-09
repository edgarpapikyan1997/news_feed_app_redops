import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redops_app/models/post_model/post_model.dart';
import 'package:redops_app/presenter/bloc/post_bloc/post_bloc.dart';
import 'package:redops_app/view/widgets/custom_nav_bar/custom_nav_bar.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  final ScrollController _scrollController = ScrollController();
  bool _hasReachedMax = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<PostBloc>(context)
        .add(const LoadPostEvent(count: 5, startIndex: 0));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final postBloc = BlocProvider.of<PostBloc>(context);
      if (postBloc.state is PostLoadedState) {
        final currentState = postBloc.state as PostLoadedState;
        if (!currentState.hasReachedMax) {
          postBloc.add(
              LoadPostEvent(count: 5, startIndex: currentState.posts.length));
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cus,
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
          print('post count ${postDataList.length}');
          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
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
                    return ListTile(
                      title: Text(postModel.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(postModel.dep),
                          Text(postModel.postDate),
                          if (postModel.image != null) Image.asset(postModel.image!),
                        ],
                      ),
                    );

                  },
                  childCount: postDataList.length + 1,
                ),
              )
            ]
          );
        }
        return Container(child: Text('Something went wrong'));
      }),
    );
  }
}
