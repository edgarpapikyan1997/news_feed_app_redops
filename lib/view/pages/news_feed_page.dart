import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redops_app/models/data/user_data_model.dart';
import 'package:redops_app/presenter/bloc/user_bloc/user_bloc.dart';
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
    BlocProvider.of<UserBloc>(context).add(LoadUserEvent(page: 1));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final userBloc = BlocProvider.of<UserBloc>(context);
      if (userBloc.state is UserLoadedState) {
        final currentState = userBloc.state as UserLoadedState;
        if (!currentState.hasReachedMax) {
          userBloc.add(LoadUserEvent(page: userBloc.page));
        }else if(!_hasReachedMax){
          _showNoMoreDataNotification();
          // _hasReachedMax = true;
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
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadingState && state is! UserLoadedState) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is UserErrorState) {
          return const Center(child: Text("Error"));
        }
        if (state is UserLoadedState) {
          List<UserDataModel> userDataList = state.users;
          return ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: userDataList.length + 1,
              itemBuilder: (_, index) {
                if (index >= userDataList.length) {
                  return state.hasReachedMax
                      ? Container()
                      : const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                return ListTile(
                    title: Text(
                      '${userDataList[index].firstName}  ${userDataList[index]
                          .lastName} \n ${userDataList[index].avatar}',
                      style: const TextStyle(color: Colors.black, fontSize: 25),
                    ));
              });
        }
        return Container(
          child: Text('Something went wrong'),
        );
      }),
    );
  }
}

