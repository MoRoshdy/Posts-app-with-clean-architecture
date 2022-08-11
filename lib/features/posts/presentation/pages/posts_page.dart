import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_with_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/widgets/posts_page_widgets/message_display_widget.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/widgets/posts_page_widgets/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text(
          'Posts',
        ),
      );

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return const LoadingWidget();
            } else if (state is LoadedPostsState) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostListWidget(posts: state.post),
              );
            } else if (state is FailedLoadingPostsState) {
              return MessageDisplayWidget(
                message: state.message,
              );
            }
            return const LoadingWidget();
          },
        ),
      );

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PostAddUpdatePage(
              isUpdatePost: false,
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
