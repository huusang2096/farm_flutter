import 'package:farmgate/locator.dart';
import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/manager_project/my_project_response.dart';
import 'package:farmgate/src/model/notification/notification_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'manager_project_cubit.freezed.dart';
part 'manager_project_state.dart';

class ManagerProjectCubit extends BaseCubit<ManagerProjectState> {
  ManagerProjectCubit() : super(Initial(Data(isLoading: false)));

  final _notificationService = locator<NotificationService>();

  void setupNotification() {
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

        if (notificationModel.type == 'project_type') {
          getMyProject();
        }
      }
    });
  }

  void getMyProject() async {
    MyProjectResponse myProjectResponse;
    try {
      emit(Loaded(state.data.copyWith(isLoading: true)));
      myProjectResponse = await dataRepository.getMyProjectResponse();
      if (myProjectResponse == null || myProjectResponse.data.length == 0) {
        emit(Loaded(state.data.copyWith(myProjects: null, isLoading: false)));
      } else {
        emit(Loaded(state.data
            .copyWith(myProjects: myProjectResponse.data, isLoading: false)));
      }
    } catch (e) {
      emit(Loaded(state.data.copyWith(isLoading: true)));
      handleAppError(e);
    }
  }

  void openDetail(MyProject item) async {
    if (item.status == "pending") {
      dialogService.showDialog(
          title: kAppName, description: 'update_user_type'.tr);
    } else {
      navigator.pushNamed(AppRoute.managerProjectDetail,
          arguments: {'project': item.project});
    }
  }
}
