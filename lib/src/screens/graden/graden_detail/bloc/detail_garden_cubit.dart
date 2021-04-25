import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/add_members/add_member_response.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/graden/garden_history_action_response.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/status_common.dart';
import 'package:simplest/simplest.dart';

import 'detail_garden_state.dart';

class GardenDetailCubit extends BaseCubit<GardenDetailState> {
  GardenDetailCubit()
      : super(Initial(DataGardenDetail(
            detail: null,
            showDeleteOrEdit: false,
            listActionGarden: [],
            shortListAction: [],
            loadingHistory: false,
            productPlan: null,
            isExpaned: true)));

  changeExpaned(bool changeExpaned) {
    emit(GardenExpaned(state.data.copyWith(isExpaned: changeExpaned)));
  }

  void getGardenDetail(int id) async {
    try {
      GardenDetailResponse response =
          await dataRepository.getGardenDetailResponse(id);
      if (response != null) {
        List<TreeList> treeLists = [];
        treeLists.add(null);
        final list = response.gardenDetail.treeList ?? [];
        treeLists.addAll(list);
        response.gardenDetail.treeList = treeLists;

        List<GardenPlantProtectionProduct> gardenPlantProtectionProducts = [];
        gardenPlantProtectionProducts.add(null);
        final listProtection =
            response.gardenDetail.gardenPlantProtectionProducts ?? [];
        gardenPlantProtectionProducts.addAll(listProtection);
        response.gardenDetail.gardenPlantProtectionProducts =
            gardenPlantProtectionProducts;

        emit(GardenDetailData(state.data.copyWith(detail: response)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  void getShortActionHistory(int gardenId) async {
    try {
      List<HistoryActionModel> shortListAction = [];
      emit(GardenHistory(state.data.copyWith(loadingHistory: true)));
      GardenHistoryActionResponse gardenHistoryActionResponse =
          await dataRepository.gardenHistoryAction(gardenId, 1);
      shortListAction = gardenHistoryActionResponse.data.data.take(4).toList();
      emit(GardenHistory(state.data.copyWith(
        shortListAction: shortListAction,
        loadingHistory: false,
      )));
    } catch (e) {
      emit(GardenHistory(state.data.copyWith(loadingHistory: false)));
      handleAppError(e);
    }
  }

  void deleteMember({String status, Member data}) async {
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
        emit(GardenDetailData(state.data.copyWith(isLoadingScaffold: true)));
        final response = await dataRepository.deleteMember(
            data.id, state.data.detail.gardenDetail.id);
        if (!response.error) {
          final detailData = state.data.detail;
          detailData.gardenDetail.memberGarden
              .removeWhere((element) => element.id == data.id);
          emit(GardenDetailData(state.data
              .copyWith(isLoadingScaffold: false, detail: detailData)));
          snackbarService.showSnackbar(message: 'deleted_successfully'.tr);
        } else {
          snackbarService.showSnackbar(message: response.message);
        }
      }
    } catch (e) {
      emit(GardenDetailData(state.data.copyWith(isLoadingScaffold: false)));
      handleAppError(e);
    }
  }

  void handleAddMember({String status, Member data}) async {
    final dataResponse =
        await navigator.pushNamed(AppRoute.addMembersScreen, arguments: {
      'data': data ?? null,
      'status': status,
      'idGarden': state.data.detail.gardenDetail.id
    }) as Map;
    if (dataResponse['data'] != null) {
      final member = dataResponse['data'] as Member;
      final detailData = state.data.detail;
      if (status == StatusAddMember.EDIT_MEMBER) {
        final index = state.data.detail.gardenDetail.memberGarden
            .indexWhere((element) => element.id == member.id);
        if (index > -1) {
          detailData.gardenDetail.memberGarden[index] = member;
          emit(GardenDetailData(state.data.copyWith(detail: detailData)));
        }
        return;
      }
    } else {
      print('nullll');
    }

    if (dataResponse['listData'].length > 0) {
      final listMember = dataResponse['listData'] as List<Member>;
      final detailData = state.data.detail;

      if (status == StatusAddMember.ADD_MEMBER) {
        detailData.gardenDetail.memberGarden.addAll(listMember);
        emit(GardenDetailData(state.data.copyWith(detail: detailData)));
        return;
      }
    }
  }

  void getListActionType() async {
    try {
      ActionGarden productPlan = null;
      ActionGardenResponse response =
          await dataRepository.getListActionGarden();
      if (response != null) {
        emit(GardenDetailData(state.data.copyWith(
            listActionGarden: response.data, productPlan: productPlan)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
