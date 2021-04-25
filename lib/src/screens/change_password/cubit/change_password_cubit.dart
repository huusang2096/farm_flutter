import 'package:farmgate/src/common/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'change_password_state.dart';

part 'change_password_cubit.freezed.dart';

class ChangePasswordCubit extends BaseCubit<ChangePasswordState> {
  ChangePasswordCubit() : super(Initial(Data()));

  void toggleShowPassword() {
    emit(ObscurePassword(
      state.data.copyWith(isPasswordObscure: !state.data.isPasswordObscure),
    ));
  }

  void toggleShowConfirmPassword() {
    emit(ObscureConfirmPassword(
      state.data.copyWith(
          isConfirmPasswordObscure: !state.data.isConfirmPasswordObscure),
    ));
  }

  void changePassword(String password, String confirmPassword) async {
    if (!(password == confirmPassword)) {
      emit(Loading(state.data.copyWith(
          validateError: 'password_and_confirm_password_mismatched'.tr)));
      return;
    }
    if (password.isEmpty || confirmPassword.isEmpty) {
      emit(Loading(state.data.copyWith(
          validateError: 'password_or_confirm_password_cannot_empty'.tr)));
      return;
    }
    if (password.length < 6 || confirmPassword.length < 6) {
      emit(Loading(state.data.copyWith(
          validateError:
              'password_or_confirm_password_cannot_less_than_6'.tr)));
      return;
    }
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      final response = await dataRepository.changePassword(password);
      emit(ChangePasswordSuccess(state.data));
      showErrorSnakeBar(response.message);
    } catch (e) {
      handleAppError(e);
    }
    emit(Loading(state.data.copyWith(isLoading: false, validateError: '')));
  }
}
