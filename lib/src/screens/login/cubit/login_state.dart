part of 'login_cubit.dart';

@freezed
abstract class LoginData with _$LoginData {
  const factory LoginData(
      {@Default(true) bool isPasswordObscure,
      @Default(false) bool isLoading,
      @Default(false) bool isExistLogin}) = DataLogin;
}

// Union
@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.init(DataLogin data) = Initial;
  const factory LoginState.loaded(DataLogin data) = Loaded;
  const factory LoginState.loading(DataLogin data) = Loading;
  const factory LoginState.loginSuccess(DataLogin data) = LoginSuccess;
}
