import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/json_post_api_clinet.dart';
import 'package:new_weather/domain/notifiers/post_state_notifier.dart';
import 'package:new_weather/presentation/text_input_state.dart';

class FormPage extends ConsumerWidget {
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
          const TextField(
            decoration: InputDecoration(hintText: 'Title text'),
          ),
          const TextField(
            decoration: InputDecoration(hintText: 'Body text'),
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
