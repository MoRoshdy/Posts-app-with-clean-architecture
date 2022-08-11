import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';

import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddUpdateDeletePostBloc,
              AddUpdateDeletePostState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDeletePost) {
                SnackBarMessage().showSnackBarMessage(
                  context,
                  state.message,
                  Colors.green,
                );

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const PostsPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorAddUpdateDeletePost) {
                Navigator.of(context).pop();
                SnackBarMessage().showSnackBarMessage(
                  context,
                  state.message,
                  Colors.redAccent,
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingAddUpdateDeletePost) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}
