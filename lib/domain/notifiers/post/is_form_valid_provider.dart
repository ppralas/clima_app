import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/domain/notifiers/post/post_state_notifier.dart';

class FormPageState {
  final bool isTitleValid;
  final bool isBodyValid;

  const FormPageState({
    this.isTitleValid = false,
    this.isBodyValid = false,
  });

  FormPageState copyWith({
    bool? isTitleValid,
    bool? isBodyValid,
    required bool isFormValid,
  }) {
    return FormPageState(
      isTitleValid: isTitleValid ?? this.isTitleValid,
      isBodyValid: isBodyValid ?? this.isBodyValid,
    );
  }
}

class FormPageStateNotifier extends StateNotifier<FormPageState> {
  Ref ref;
  FormPageStateNotifier(this.ref) : super(const FormPageState());

  void validateForm(String title, String body) {
    final isTitleEmpty = title.isEmpty;
    final isBodyEmpty = body.isEmpty;

    state = state.copyWith(
      isTitleValid: !isTitleEmpty,
      isBodyValid: !isBodyEmpty,
      isFormValid: !isTitleEmpty && !isBodyEmpty,
    );
  }

  void submitForm(String title, String body) {
    if (state.isTitleValid && state.isBodyValid) {
      ref
          .watch(postValueProvider.notifier)
          .publishPost(body: body, title: title);
      print('submitted');
    }
  }
}
