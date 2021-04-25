import 'dart:developer';
import 'dart:io';

import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/register/register_request_model.dart';
import 'package:farmgate/src/model/register/register_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

import '../../../../routes.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit() : super(Initial(DataRegister()));

  final _phoneAuthService = locator<PhoneAuthService>();

  submit(
      {String firstName,
      String lastName,
      String email,
      String phone,
      String password,
      String confirmPassword,
      String countryCode}) async {
    try {
      RegisterRequest registerRequest = RegisterRequest(
          firstName: firstName,
          lastName: lastName,
          email: email.isNotEmpty ? email : null,
          phone: phone,
          password: password,
          passwordConfirmation: confirmPassword);

      if (_validateRequest(registerRequest).isNotEmpty) {
        await showErrorMessage(_validateRequest(registerRequest));
        return;
      }
      emit(Loading(state.data.copyWith(isLoading: true)));
      final responseVerifyToken =
          await _phoneAuthService.verifyPhoneNumber(phone);

      if (responseVerifyToken.verifyToken.isBlank) {
        emit(Loading(state.data.copyWith(isLoading: false)));
        return;
      }
      registerRequest.verifyToken = responseVerifyToken.verifyToken;

      log("Veryfile token" + registerRequest.verifyToken);
      registerRequest.platform = Platform.operatingSystem.toString();
      registerRequest.fcmToken =
          appPref.fcmToken.isBlank ? 'fcm_token' : appPref.fcmToken;
      registerRequest.deviceId = await DeviceHelper.deviceId;
      registerRequest.countryCode = countryCode;

      log(registerRequest.toRawJson());

      RegisterResponse registerResponse =
          await dataRepository.register(registerRequest);
      emit(Loading(state.data.copyWith(isLoading: false)));
      if (!registerResponse.error) {
        final dialogResponse = await dialogService.showDialog(
          title: kAppName,
          description: 'register_success'.tr,
        );
        if (dialogResponse.confirmed) {
          navigator.pushNamedAndRemoveUntil(
              AppRoute.loginWithPhoneScreen, (route) => false);
          return;
        }
      }
    } catch (error) {
      log(error.toString());
      handleAppError(error);
    }
    emit(Loading(state.data.copyWith(isLoading: false)));
  }

  @override
  void handleAppError(error) {
    if (error is DioError) {
      final response = error.response?.data ?? {"message": "server_error"};
      if (error.response?.statusCode == 422) {
        if (response is Map) {
          final message = response['errors']['phone'] ?? ['register_fail'.tr];

          dialogService.showDialog(title: kAppName, description: message.first);
          return;
        }

        dialogService.showDialog(
            title: kAppName, description: 'register_fail'.tr);
        return;
      }
    }
    return super.handleAppError(error);
  }

  /// Validate request, return error key, empty if success
  String _validateRequest(RegisterRequest request) {
    if (request.firstName.isEmpty ||
        request.lastName.isEmpty ||
        request.phone.isEmpty ||
        request.password.isEmpty ||
        request.passwordConfirmation.isEmpty) {
      return 'all_field_is_required'.tr;
    }

    if (request.email != null) {
      if (!request.email.isEmail) {
        return 'email_incorrect_format'.tr;
      }
    }

    if (request.passwordConfirmation != request.password) {
      return 'password_not_match'.tr;
    }

    return '';
  }
}
