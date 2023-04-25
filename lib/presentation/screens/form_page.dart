// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/domain/notifiers/post/is_form_valid_provider.dart';

final formPageProvider =
    StateNotifierProvider.autoDispose<FormPageStateNotifier, FormPageState>(
        (ref) => FormPageStateNotifier(ref));

class FormPage extends ConsumerStatefulWidget {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // Validator tu prima text kojeg je user unio u formtextfield
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Title text',
                errorText: ref.watch(formPageProvider).isTitleValid
                    ? null
                    : 'Title is required',
              ),
              controller: widget._titleController,
              onChanged: (value) {
                ref
                    .read(formPageProvider.notifier)
                    .validateForm(value, widget._bodyController.text);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                //Ista stvar ko na liniji 47
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Body text',
                  errorText: ref.watch(formPageProvider).isBodyValid
                      ? null
                      : 'Body is required',
                ),
                controller: widget._bodyController,
                onChanged: (value) {
                  ref
                      .read(formPageProvider.notifier)
                      .validateForm(value, widget._bodyController.text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: ref.watch(formPageProvider).isBodyValid &&
                          ref.watch(formPageProvider).isTitleValid
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            //ako je forma validna prikazem snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Submitam Datu'),
                              ),
                            );
                          }
                          print('Submitted');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ref.watch(formPageProvider).isBodyValid &&
                            ref.watch(formPageProvider).isTitleValid
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
