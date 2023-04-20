import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/domain/notifiers/post_state_notifier.dart';
import 'package:new_weather/presentation/text_cntroller.dart';

class FormPage extends ConsumerWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final client = ref.watch(postClientProvider);

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
            controller: titleController,
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Body text'),
            controller: bodyController,
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(postValueProvider.notifier).publishPost();
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
