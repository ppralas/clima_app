import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostFormState {
  final bool isTitleEmpty;
  final bool isBodyEmpty;

  PostFormState({
    required this.isTitleEmpty,
    required this.isBodyEmpty,
  });
}

class PostFormStateNotifier extends StateNotifier<PostFormState> {
  final TextEditingController titleController;
  final TextEditingController bodyController;

  PostFormStateNotifier({
    required this.titleController,
    required this.bodyController,
  }) : super(PostFormState(
          isTitleEmpty: titleController.text.isEmpty,
          isBodyEmpty: bodyController.text.isEmpty,
        ));

  void validateForm() {
    final isTitleEmpty = titleController.text.isEmpty;
    final isBodyEmpty = bodyController.text.isEmpty;

    state = PostFormState(
      isTitleEmpty: isTitleEmpty,
      isBodyEmpty: isBodyEmpty,
    );
  }
}
