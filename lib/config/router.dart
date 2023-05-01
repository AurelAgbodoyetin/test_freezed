import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_freezed/presentation/screens/home/home.dart';
import 'package:test_freezed/presentation/screens/posts/list.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const CounterPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "posts",
          builder: (BuildContext context, GoRouterState state) {
            return const PostsListScreen();
          },
        ),
      ],
    ),
  ],
);
