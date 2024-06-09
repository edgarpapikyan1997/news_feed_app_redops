import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redops_app/http/dio/dio_client.dart';
import 'package:redops_app/http/repositories/post_repository.dart';
import 'package:redops_app/http/repositories/user_repository.dart';
import 'package:redops_app/presenter/bloc/post_bloc/post_bloc.dart';
import 'package:redops_app/presenter/bloc/user_bloc/user_bloc.dart';

import 'app_ config.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  var configuredApp = AppConfig(
    appName: 'RedOps app DEV',
    flavorName: 'development',
    apiBaseUrl: 'https://reqres.in/api',
    child: const App(),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) =>
                UserBloc(UserRepository())..add(const LoadUserEvent(page: 0)),
          ),
          BlocProvider<PostBloc>(
            create: (context) =>
                PostBloc(PostRepository())..add(const LoadPostEvent(count: 0, startIndex: 0, )),
          ),
        ],
        child: configuredApp,
      ),
    ),
  );
}
