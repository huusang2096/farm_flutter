import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:simplest/simplest.dart';

import 'graden_state.dart';

class GradenCubit extends BaseCubit<GradenState> {
  GradenCubit()
      : super(Initial(Data(
            myGarden: [],
            isGardenMap: false,
            isLoadingScaffold: false,
            pinPillPosition: -500,
            currentlySelectedPin: null)));

  getMyGarden() async {
    try {
      GardenResponse response = await dataRepository.getMyGraden();
      if (response != null) {
        List<MyGarden> gardens = [];
        gardens.add(null);
        gardens.addAll(response.data);
        gardens.map((e) => null);
        emit(ListGraden(state.data.copyWith(myGarden: gardens)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  void deleteGarden(MyGarden data) async {
    final responseDialog = await dialogService.showDialog(
        title: appConfig.appName,
        description: 'do_you_want_to_delete_click_agree_to_delete_garden'
            .trArgs(['${data.name ?? ''}', '\n']),
        buttonTitle: 'ok'.tr,
        cancelTitle: 'cancel'.tr);
    if (!responseDialog.confirmed) {
      return;
    }

    try {
      {
        emit(GradenLoading(state.data.copyWith(isLoadingScaffold: true)));
        final response = await dataRepository.delete(data.id);
        if (!response.error) {
          List<MyGarden> listData = [...state.data.myGarden];
          listData.remove(data);
          emit(ListGraden(state.data
              .copyWith(myGarden: listData, isLoadingScaffold: false)));
          snackbarService.showSnackbar(message: 'deleted_successfully'.tr);
        } else {
          snackbarService.showSnackbar(message: response.message);
        }
      }
    } catch (e) {
      emit(GradenLoading(state.data.copyWith(isLoadingScaffold: false)));
      handleAppError(e);
    }
  }

  changeMapGarden() async {
    try {
      bool isGardenMapChange = !state.data.isGardenMap;
      emit(ListGraden(state.data.copyWith(isGardenMap: isGardenMapChange)));
    } catch (e) {
      handleAppError(e);
    }
  }

  updatePinPillPosition(double pinPillPosition, MyGarden currentlySelectedPin) {
    emit(UpdatePinPillPosition(state.data.copyWith(
        pinPillPosition: pinPillPosition,
        currentlySelectedPin: currentlySelectedPin)));
  }
}
