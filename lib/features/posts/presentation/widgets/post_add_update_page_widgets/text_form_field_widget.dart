
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final int lines;

  const TextFormFieldWidget({super.key, required this.name, required this.controller, required this.lines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (val) => val!.isEmpty ? '$name can\'t be empty' : null,
      decoration: InputDecoration(hintText: name),
      minLines: lines,
      maxLines: lines,
    );
  }
}

