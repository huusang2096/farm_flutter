import 'package:farmgate/locator.dart';
import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/storage/app_prefs.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/repository/data_repository.dart';
import 'package:simplest/simplest.dart';

class BaseCubit<State> extends GenericBaseCubit<State> {
  BaseCubit(State state) : super(state);
  DataRepository get dataRepository => locator<DataRepository>();
  AppPref get appPref => locator<AppPref>();

  @override
  IAppConfig get appConfig => locator<IAppConfig>();

  @override
  handleAppError(error) async {
    logger.e(error);

    if (error is String) {
      return showErrorSnakeBar(error);
    }

    if (error is DioError) {
      return parseDioError(error);
    }

    return showErrorSnakeBar('unknow_error'.tr);
  }

  parseDioError(DioError error) async {
    final _hasNetwork = await networkActivity.hasNetwork;
    if (!_hasNetwork) {
      return networkActivity.showRequireNetwork();
    }

    // Check status code
    final token = appPref.token;
    if (error.response?.statusCode == 401 && token.isNotEmpty) {
      await appPref.logout();
      dataRepository.loadAuthHeader();
      await navigator.pushNamedAndRemoveUntil(
          AppRoute.loginWithPhoneScreen, (route) => false,
          arguments: {'force_logout_message': 'please_re_log_in'});
      return;
    }

    var errorMessage = 'server_error';
    final response = error.response?.data ?? {"message": "server_error"};
    try {
      if (response is Map) {
        final errResponse = BaseResponse.fromJson(response);
        errorMessage = errResponse.message;
      } else if (response is String) {
        final errResponse = BaseResponse.fromRawJson(response);
        errorMessage = errResponse.message;
      } else if (error.error is TypeError) {
        final err = error.error as TypeError;
        errorMessage = err.toString();
      }
    } catch (e) {
      print(e);
    }

    return showErrorSnakeBar(errorMessage.tr);
  }

  showErrorSnakeBar(String error) {
    snackbarService.showSnackbar(message: error.tr);
  }
}
