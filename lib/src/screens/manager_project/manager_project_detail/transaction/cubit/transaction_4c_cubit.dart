import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/manager_project/mem_partner_project_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'transaction_4c_cubit.freezed.dart';
part 'transaction_4c_state.dart';

class Transaction4cCubit extends BaseCubit<Transaction4cState> {
  Transaction4cCubit()
      : super(Initial(Data(
            isLoading: false,
            isSelectedTypeOfProduct: 0,
            isSelectedMethodTransaction: 0,
            members: null,
            partnerSelect: null,
            isSale: true)));

  void isSelectedTypeOfProduct(int index) {
    emit(SelectedTypeOfProduct(
        state.data.copyWith(isSelectedTypeOfProduct: index)));
  }

  void onSelectItem(MemberPartner member) async {
    try {
      emit(GetMemberPartner(state.data.copyWith(partnerSelect: member)));
    } catch (e) {
      handleAppError(e);
    }
  }

  void isSelectedMethodTransaction(int index) {
    emit(SelectedMethodTransaction(
        state.data.copyWith(isSelectedMethodTransaction: index)));
  }

  void getMemberPartnerProject(int id) async {
    try {
      final response =
          await dataRepository.getMemberPartnerProject(id.toString());
      if (response.data != null) {
        emit(GetMemberPartner(state.data.copyWith(members: response.data)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  void submit(
      int idProject,
      String numOfContract,
      String quantity,
      String price,
      String tripNumber,
      String reward4c,
      String date,
      String typeGoods,
      String typeSale,
      String sum4c,
      String sum) async {
    final duration = Duration(milliseconds: 1500);
    if (quantity.isEmpty) {
      snackbarService.showSnackbar(
          message: 'please_input_quantity'.tr, duration: duration);
      return;
    }
    if (price.isEmpty && state.data.isSelectedMethodTransaction == 0) {
      snackbarService.showSnackbar(
          message: 'please_input_price'.tr, duration: duration);
      return;
    }
    if (reward4c.isEmpty) {
      snackbarService.showSnackbar(
          message: 'please_input_reward4c'.tr, duration: duration);
      return;
    }

    if (state.data.partnerSelect == null) {
      snackbarService.showSnackbar(
          message: 'choose_buyer'.tr, duration: duration);
      return;
    }
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      BaseResponse baseResponse;

      baseResponse = await dataRepository.addOrder(
          idProject,
          date,
          numOfContract ?? "",
          quantity,
          price,
          tripNumber ?? "",
          reward4c,
          typeGoods,
          typeSale,
          state.data.partnerSelect.id.toString(),
          sum4c,
          sum);
      emit(Loading(state.data.copyWith(isLoading: false)));

      if (!baseResponse.error) {
        final dialogResponse = await dialogService.showDialog(
            title: kAppName, description: 'create_order_success'.tr);
        if (dialogResponse.confirmed) {
          navigator.pop();
          return;
        }
      } else {
        snackbarService.showSnackbar(message: baseResponse.message);
      }
    } catch (e) {
      emit(Loading(state.data.copyWith(isLoading: false)));
      handleAppError(e);
    }
  }
}
