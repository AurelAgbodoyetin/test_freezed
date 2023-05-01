import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_freezed/presentation/logic/counter/counter_cubit.dart';
import 'package:test_freezed/presentation/logic/posts/posts_cubit.dart';
import 'package:test_freezed/presentation/screens/posts/list.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        return state.map(
          loading: (state) {
            return Scaffold(
              appBar: AppBar(title: const Text('Counter Page')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox.square(
                      dimension: 40.0,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            );
          },
          loaded: (state) {
            return Scaffold(
              appBar: AppBar(title: const Text('Flutter Demo Home Page')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      state.value.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment(state.value);
                    },
                    tooltip: 'Increment',
                    heroTag: "increment",
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 10.0),
                  FloatingActionButton(
                    heroTag: "decrement",
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement(state.value);
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(height: 10.0),
                  FloatingActionButton(
                    heroTag: "posts",
                    onPressed: () {
                      context.go(PostsListScreen.route);
                      BlocProvider.of<PostsCubit>(context).getPosts();
                    },
                    tooltip: 'Posts',
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
