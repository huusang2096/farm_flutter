import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/manager_project/all_project_response.dart';
import 'package:farmgate/src/model/manager_project/mem_partner_project_response.dart';
import 'package:farmgate/src/model/manager_project/request_join_project.dart';
import 'package:farmgate/src/model/profile/profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'all_project_cubit.freezed.dart';
part 'all_project_state.dart';

class AllProjectCubit extends BaseCubit<AllProjectState> {
  AllProjectCubit()
      : super(Initial(Data(
            isLoading: false,
            allProjectResponse: null,
            members: null,
            isAdd: false,
            timeUpdate: DateTime.now())));

  void getAllProject() async {
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      final response = await dataRepository.getAllProject();
      if (response.data != null) {
        emit(GetAllProject(state.data.copyWith(allProjectResponse: response)));
      }
    } catch (e) {
      handleAppError(e);
    }
    emit(Loading(state.data.copyWith(isLoading: false)));
  }

  void onSelectItem(MemberPartner member) async {
    try {
      if (state.data.user.permission == 3) {
        state.data.members.forEach((data) {
          if (data.id == member.id) {
            data.isSelect = true;
          } else {
            data.isSelect = false;
          }
        });
      } else {
        state.data.members.forEach((data) {
          if (data.id == member.id) {
            data.isSelect = !member.isSelect;
          }
        });
      }
      emit(GetMemberPartner(state.data.copyWith(timeUpdate: DateTime.now())));
    } catch (e) {
      handleAppError(e);
    }
  }

  void joinProject(int id) async {
    try {
      emit(Loading(state.data.copyWith(isAdd: true)));
      RequestJoinProject requestJoinProject = RequestJoinProject();
      List<String> listID = [];
      requestJoinProject.partner = listID;
      BaseResponse response;

      response = await dataRepository.joinProject(id, requestJoinProject);
      emit(Loading(state.data.copyWith(isAdd: false)));

      if (!response.error) {
        final dialogResponse = await dialogService.showDialog(
            title: kAppName, description: 'update_user_type'.tr);
        if (dialogResponse.confirmed) {
          navigator.pop();
          return;
        }
      } else {
        snackbarService.showSnackbar(message: response.message);
      }
    } catch (e) {
      emit(Loading(state.data.copyWith(isAdd: false)));
      handleAppError(e);
    }
  }

  void getMemberPartnerProject(int id) async {
    try {
      Profile user = appPref.getUser().data;
      emit(Loading(state.data.copyWith(isLoading: true)));
      final response =
          await dataRepository.getMemberPartnerProject(id.toString());
      if (response.data != null) {
        emit(GetMemberPartner(
            state.data.copyWith(members: response.data, user: user)));
      }
    } catch (e) {
      handleAppError(e);
    }
    emit(Loading(state.data.copyWith(isLoading: false)));
  }
}
