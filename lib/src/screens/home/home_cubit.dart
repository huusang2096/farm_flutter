import 'dart:developer';

import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/notification/fcm_request.dart';
import 'package:farmgate/src/model/notification/notification_response.dart';
import 'package:simplest/simplest.dart';

import '../../../locator.dart';
import '../../../routes.dart';
import 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(Initial(Data(indexTab: 1)));

  final _notificationService = locator<NotificationService>();

  changeTab(int index) {
    emit(ChangeTab(state.data.copyWith(indexTab: index)));
  }

  setup() async {
    _setupNotification();
  }

  void _setupNotification() {
    // Settings up fcmtoken
    _notificationService.requestPermission();
    final fcmToken = _notificationService.fcmToken;
    appPref.fcmToken = fcmToken;
    _submitFcmToken(fcmToken);
    _notificationService.tokenStream.listen((token) {
      _submitFcmToken(token);
    });
    log('fcmToken $fcmToken');

    // Handle recevied notification data
    _notificationService.dataStream.listen((event) {
      var data;
      if (event.containsKey('onResume')) {
        data = event['onResume'];
      } else if (event.containsKey('onSelectLocalNotification')) {
        data = event['onSelectLocalNotification'];
      } else if (event['onMessage']) {
        data = event['onMessage'];
      } else if (event['onLaunch']) {
        data = event['onLaunch'];
      }

      if (data != null) {
        NotificationModel notificationModel =
            NotificationModel.fromRawJson(data);

        if (notificationModel.type == 'member_type') {
          emit(UpdateUser(state.data));
        } else if (notificationModel.type == 'project_type') {
        } else if (notificationModel.type == 'transaction_type') {
          int id = int.parse(notificationModel.orderId);
          navigator.pushNamed(AppRoute.confirmTransactionScreen,
              arguments: {'requestID': id});
        }
      }
    });
  }

  void _submitFcmToken(String token) async {
    try {
      if (appPref.token.isEmpty) {
        return;
      }
      FcmRequest fcmRequest = new FcmRequest(
          deviceId: await DeviceHelper.deviceId,
          platform: DeviceHelper.deviceType,
          fcmToken: token);
      await dataRepository.pushFCMToken(fcmRequest);
    } catch (e) {
      //handleAppError(e);
    }
  }
}
