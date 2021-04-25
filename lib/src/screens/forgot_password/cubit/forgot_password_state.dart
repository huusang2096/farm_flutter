part of 'forgot_password_cubit.dart';

@freezed
abstract class ForgotPasswordStateData with _$ForgotPasswordStateData {
  const factory ForgotPasswordStateData(
      {@nullable ForgotPasswordResponse forgotPasswordResponse,
      @Default(false) bool isLoading,
      @Default('') String errorValidate}) = Data;
}

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial(Data data) = Initial;
  const factory ForgotPasswordState.forgotPassword(Data data) = ForgotPassword;
  const factory ForgotPasswordState.loading(Data data) = Loading;
}
