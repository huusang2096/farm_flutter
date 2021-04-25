import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/forgot_password/forgot_password_request.dart';
import 'package:farmgate/src/model/forgot_password/forgot_password_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'forgot_password_cubit.freezed.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState.initial(Data()));

  handleForgotError(error) {
    if (error is DioError) {
      if (error.response?.statusCode == 422) {
        showErrorSnakeBar('account_does_not_have'.tr);
      } else {
        handleAppError(error);
      }
    } else {
      handleAppError(error);
    }
  }

  Future<void> resetPassword(
      {String phone, String password, String confirmPassword}) async {
    final _phoneAuthService = locator<PhoneAuthService>();
    try {
      emit(Loading(state.data.copyWith(isLoading: true, errorValidate: '')));
      final responseVerifyToken =
          await _phoneAuthService.verifyPhoneNumber(phone);

      if (responseVerifyToken.verifyToken.isBlank) {
        return;
      }
      final ForgotPasswordRequest request = ForgotPasswordRequest(
        phone: phone,
        password: password,
        passwordConfirmation: confirmPassword,
        verifyToken: responseVerifyToken.verifyToken,
      );
      final response = await dataRepository.forgotPassword(request);
      emit(ForgotPassword(
          state.data.copyWith(forgotPasswordResponse: response)));
      if (!response.error) {
        var isConfirm = await dialogService.showConfirmationDialog(
            title: kAppName,
            description: 'password_reset_was_successful'.tr,
            confirmationTitle: 'ok'.tr,
            cancelTitle: null);
        if (isConfirm.confirmed) {
          navigator.pop();
        }
      }
    } catch (e) {
      handleForgotError(e);
      emit(Loading(state.data.copyWith(isLoading: false, errorValidate: '')));
    }
    emit(Loading(state.data.copyWith(isLoading: false, errorValidate: '')));
  }
}
