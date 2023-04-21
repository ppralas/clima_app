import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/model/post_repository.dart';
import 'package:new_weather/domain/notifiers/post/post_state.dart';
import 'package:new_weather/domain/notifiers/post/post_state_notifier.dart';

final postValueProvider = StateNotifierProvider<PostStateNotifier, PostState>(
    (ref) => PostStateNotifier(ref.watch(postRepositoryProvider)));

class FormPage extends ConsumerStatefulWidget {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  bool _isFormValid = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget._titleController.dispose();
    widget._bodyController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isTitleEmpty = widget._titleController.text.isEmpty;
    final isBodyEmpty = widget._bodyController.text.isEmpty;

    setState(() {
      _isFormValid = !isTitleEmpty && !isBodyEmpty;
    });
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
            onChanged: (_) => _validateForm(),
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Body text'),
            controller: widget._bodyController,
            onChanged: (_) => _validateForm(),
          ),
          ElevatedButton(
            onPressed: _isFormValid
                ? () {
                    ref.watch(postValueProvider.notifier).publishPost(
                          body: '',
                          title: '',
                        );
                    print('submited');
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isFormValid ? Colors.blue : Colors.grey,
            ),
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
