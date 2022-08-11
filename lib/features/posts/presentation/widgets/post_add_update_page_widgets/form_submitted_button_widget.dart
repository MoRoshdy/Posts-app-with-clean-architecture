import 'package:flutter/material.dart';

class SubmittedButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const SubmittedButtonWidget({super.key, required this.onPressed, required this.isUpdatePost});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isUpdatePost
          ? const Icon(Icons.edit)
          : const Icon(Icons.add),
      label: isUpdatePost ? const Text('Edit') : const Text('Add'),
    );
  }
}
