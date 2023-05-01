import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_freezed/config/router.dart';
import 'package:test_freezed/data/repositoty/post.dart';
import 'package:test_freezed/presentation/logic/counter/counter_cubit.dart';
import 'package:test_freezed/presentation/logic/posts/posts_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepositoryImpl(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CounterCubit>(
            create: (BuildContext context) => CounterCubit(),
          ),
          BlocProvider<PostsCubit>(
            create: (BuildContext context) => PostsCubit(
              repo: RepositoryProvider.of<PostsRepositoryImpl>(context),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorSchemeSeed: Colors.teal,
            useMaterial3: true,
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}
