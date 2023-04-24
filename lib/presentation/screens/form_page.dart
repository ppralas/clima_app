// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/domain/notifiers/post/post_state_notifier.dart';

final formPageProvider =
    StateNotifierProvider.autoDispose<FormPageStateNotifier, FormPageState>(
        (ref) => FormPageStateNotifier(ref));

class FormPageStateNotifier extends StateNotifier<FormPageState> {
  Ref ref;
  FormPageStateNotifier(this.ref) : super(const FormPageState());

  void validateForm(String title, String body) {
    final isTitleEmpty = title.isEmpty;
    final isBodyEmpty = body.isEmpty;

    state = state.copyWith(isFormValid: !isTitleEmpty && !isBodyEmpty);
  }

  void submitForm(String title, String body) {
    if (state.isFormValid) {
      ref
          .watch(postValueProvider.notifier)
          .publishPost(body: body, title: title);
      print('submitted');
    }
  }
}

class FormPageState {
  final bool isFormValid;

  const FormPageState({this.isFormValid = false});

  FormPageState copyWith({bool? isFormValid}) {
    return FormPageState(isFormValid: isFormValid ?? this.isFormValid);
  }
}

class FormPage extends ConsumerStatefulWidget {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget._titleController.dispose();
    widget._bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Weather screen'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'Title text'),
            controller: widget._titleController,
            onChanged: (value) {
              ref
                  .read(formPageProvider.notifier)
                  .validateForm(value, widget._bodyController.text);
            },
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Body text'),
            controller: widget._bodyController,
            onChanged: (value) {
              ref
                  .read(formPageProvider.notifier)
                  .validateForm(widget._titleController.text, value);
            },
          ),
          ElevatedButton(
            onPressed: ref.watch(formPageProvider).isFormValid
                ? () {
                    ref.read(formPageProvider.notifier).submitForm(
                        widget._titleController.text,
                        widget._bodyController.text);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: ref.watch(formPageProvider).isFormValid
                  ? Colors.blue
                  : Colors.grey,
            ),
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
