import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/widgets/post_add_update_page_widgets/form_submitted_button_widget.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/widgets/post_add_update_page_widgets/text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;

  const FormWidget({super.key, this.post, required this.isUpdatePost});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }

    super.initState();
  }

  updateOrAddPost() {
    final post = Post(
      id: widget.isUpdatePost ? widget.post!.id : null,
      title: _titleController.text,
      body: _bodyController.text,
    );

    if (_formKey.currentState!.validate()) {
      if (widget.isUpdatePost) {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      }else{
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            name: 'Title',
            controller: _titleController,
            lines: 1,
          ),
          TextFormFieldWidget(
            name: 'Body',
            controller: _bodyController,
            lines: 6,
          ),
          SubmittedButtonWidget(
            onPressed: updateOrAddPost,
            isUpdatePost: widget.isUpdatePost,
          )
        ],
      ),
    );
  }
}
