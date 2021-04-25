import 'dart:developer';

import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/login/login_request.dart';
import 'package:farmgate/src/model/login/login_response.dart';
import 'package:local_auth/local_auth.dart';
import 'package:simplest/simplest.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../routes.dart';
part 'login_state.dart';

part 'login_cubit.freezed.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(Initial(LoginData()));

  void checkExistLogin() {
    final loginRequest = appPref?.loginRequest;
    if (loginRequest != null) {
      emit(Loaded(state.data.copyWith(isExistLogin: true)));
    }
  }

  void submitLogin({String phone, String password}) async {
    LoginRequest request = LoginRequest(password: password, phone: phone);

    if (request.password.isBlank) {
      snackbarService.showSnackbar(message: 'please_choose_a_password'.tr);
      return;
    }
    _loginWithRequest(request);
  }

  void _loginWithRequest(LoginRequest loginRequest) async {
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      LoginResponse response = await dataRepository.login(loginRequest);
      if (response.data != null) {
        await appPref.setToken(response.data.token);
        await dataRepository.loadAuthHeader();
        log(response.data.token);
        appPref.loginRequest = loginRequest;
        navigator.pushNamedAndRemoveUntil(
            AppRoute.homeScreen, (route) => false);
      } else {
        throw response.message ?? 'unknow_error'.tr;
      }
    } catch (e) {
      showErrorSnakeBar('email_and_password_is_not_correct'.tr);
    }
    emit(Loading(state.data.copyWith(isLoading: false)));
  }

  void toggleShowPassword() {
    bool isPasswordObscure = !state.data.isPasswordObscure;
    emit(Loaded(state.data.copyWith(isPasswordObscure: isPasswordObscure)));
  }

  void logInWithAnOtherAccount() {
    appPref.loginRequest = null;
    emit(Loaded(state.data.copyWith(isExistLogin: false)));
  }
}
