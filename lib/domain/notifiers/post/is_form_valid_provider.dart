import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormPageState {
  final bool isFormValid;
  //final bool isBodyValid;

  const FormPageState({
    required this.isFormValid,
    // this.isBodyValid = false,
  });

  FormPageState copyWith({
    required bool isFormValid,
  }) {
    return FormPageState(
      isFormValid: isFormValid,
      //isBodyValid: isBodyValid ?? this.isBodyValid,
    );
  }
}

class FormPageStateNotifier extends StateNotifier<FormPageState> {
  Ref ref;
  FormPageStateNotifier(this.ref)
      : super(const FormPageState(isFormValid: false));

  void validateForm(bool isFormValid) {
    state = state.copyWith(
      isFormValid: isFormValid,
    );
  }

  // void submitForm(String title, String body) {
  //   if (state.isTitleValid && state.isBodyValid) {
  //     ref
  //         .watch(postValueProvider.notifier)
  //         .publishPost(body: body, title: title);
  //     print('submitted');
  //   }
  // }
}
