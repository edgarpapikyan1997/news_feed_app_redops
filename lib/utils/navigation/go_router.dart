import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redops_app/view/pages/news_feed_page.dart';


final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const NewsFeedPage();
      },
    ),
  ],
);
