import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_freezed/presentation/logic/posts/posts_cubit.dart';
import 'package:test_freezed/presentation/screens/posts/widgets/card.dart';

class PostsListScreen extends StatelessWidget {
  static String route = "/posts";
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsCubit, PostsState>(
      listener: (context, state) {
        state.mapOrNull(failure: (state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(5),
            ),
          );
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<PostsCubit, PostsState>(
                  buildWhen: (previous, current) {
                    return current is! Failure && (previous != current);
                  },
                  builder: (context, state) {
                    return state.map(
                      loading: (state) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox.square(
                                dimension: 40.0,
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        );
                      },
                      loaded: (state) {
                        if (state.posts.isEmpty) {
                          return const Center(child: Text("Aucun véhicule"));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10.0,
                            ),
                            itemCount: state.posts.length,
                            itemBuilder: (context, index) {
                              return PostCard(post: state.posts.elementAt(index));
                            },
                          );
                        }
                      },
                      failure: (_) {
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
