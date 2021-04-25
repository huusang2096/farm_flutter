part of 'change_password_cubit.dart';

@freezed
abstract class ChangePasswordDataState with _$ChangePasswordDataState {
  const factory ChangePasswordDataState({
    @Default(true) bool isPasswordObscure,
    @Default(true) bool isConfirmPasswordObscure,
    @Default(false) bool isLoading,
    @Default('') String validateError,
  }) = Data;
}

@freezed
abstract class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.init(ChangePasswordDataState data) =
      Initial;
  const factory ChangePasswordState.loading(ChangePasswordDataState data) =
      Loading;
  const factory ChangePasswordState.obscurePass(ChangePasswordDataState data) =
      ObscurePassword;
  const factory ChangePasswordState.obscureConfirmPass(
      ChangePasswordDataState data) = ObscureConfirmPassword;
  const factory ChangePasswordState.changeSucces(ChangePasswordDataState data) =
      ChangePasswordSuccess;
}
