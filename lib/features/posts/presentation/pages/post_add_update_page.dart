import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_with_clean_architecture/core/util/snackbar_message.dart';
import 'package:posts_app_with_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/widgets/post_add_update_page_widgets/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(
          isUpdatePost ? 'Edit Post' : 'Add Post',
        ),
      );

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is MessageAddUpdateDeletePost) {
              SnackBarMessage().showSnackBarMessage(context, state.message, Colors.green);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostsPage(),
                ),
                (route) => false,
              );
            } else if(state is ErrorAddUpdateDeletePost){
              SnackBarMessage().showSnackBarMessage(context, state.message, Colors.redAccent);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddUpdateDeletePost) {
              return const LoadingWidget();
            }
            return FormWidget(isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null,);
          },
        ),
      ),
    );
  }
}
