import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/add_members/add_member_response.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/pepole_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'people_cubit.freezed.dart';
part 'people_state.dart';

class PeopleCubit extends BaseCubit<PeopleState> {
  PeopleCubit() : super(Initial(Data()));

  void getAllPepole() async {
    PeopleResponse peopleResponse;
    try {
      peopleResponse = await dataRepository.getAllPeople();
      emit(Loaded(state.data
          .copyWith(listMember: peopleResponse.data, isLoading: false)));
    } catch (e) {
      handleAppError(e);
    }
  }

  void addGraden(int memberID, GardenDetail graden) async {
    emit(Loaded(state.data.copyWith(isLoading: true)));
    BaseResponse response;
    try {
      response = await dataRepository.addPeopleToGraden(memberID, graden.id);
      if (response.error) {
        snackbarService.showSnackbar(message: 'add_people_failed'.tr);
      } else {
        snackbarService.showSnackbar(message: response.message);
      }
      emit(Loaded(state.data.copyWith(isLoading: false)));
    } catch (e) {
      emit(Loaded(state.data.copyWith(isLoading: false)));
      handleAppError(e);
    }
  }

  void deletePeople({String status, Member data}) async {
    final responseDialog = await dialogService.showDialog(
        title: appConfig.appName,
        description: 'do_you_want_to_delete_click_agree_to_delete_member'
            .trArgs(['${data.name ?? ''}', '\n']),
        buttonTitle: 'ok'.tr,
        cancelTitle: 'cancel'.tr);
    if (!responseDialog.confirmed) {
      return;
    }
    try {
      {
        emit(Loaded(state.data.copyWith(isLoading: true)));
        final response = await dataRepository.deletePeople(data.id);
        if (!response.error) {
          final listMemberData = state.data.listMember;
          listMemberData.removeWhere((element) => element.id == data.id);
          emit(Loaded(state.data
              .copyWith(isLoading: false, listMember: listMemberData)));
          snackbarService.showSnackbar(message: 'deleted_successfully'.tr);
        } else {
          snackbarService.showSnackbar(message: response.message);
        }
      }
    } catch (e) {
      emit(Loaded(state.data.copyWith(isLoading: false)));
      handleAppError(e);
    }
  }

  void handlePeople({String status, Member data}) async {
    final dataResponse = await navigator.pushNamed(AppRoute.addMembersScreen,
            arguments: {'data': data ?? null, 'status': status, 'idGarden': 0})
        as Map;
    getAllPepole();
  }
}
