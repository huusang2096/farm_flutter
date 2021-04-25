import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/manager_project/history_detail_response.dart';
import 'package:farmgate/src/model/manager_project/history_project.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'confirm_transaction_cubit.freezed.dart';
part 'confirm_transaction_state.dart';

class ConfirmTransactionCubit extends BaseCubit<ConfirmTransactionState> {
  ConfirmTransactionCubit()
      : super(Initial(Data(isLoading: false, historyTransaction: null)));

  Future<void> saleCancel(int id, String reason) async {
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      BaseResponse baseResponse;

      baseResponse = await dataRepository.userSaleCancel(id, reason);
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

  Future<void> getDetailTrainsaction(int id) async {
    try {
      HistoryTransactionDetalResponse historyTransactionDetalResponse;

      historyTransactionDetalResponse =
          await dataRepository.getHistoryTransactionDetail(id.toString());
      if (!historyTransactionDetalResponse.error) {
        emit(GetHistoryTransaction(state.data.copyWith(
            historyTransaction: historyTransactionDetalResponse.data)));
      } else {
        snackbarService.showSnackbar(
            message: historyTransactionDetalResponse.message);
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  Future<void> buyCancel(int id, String reason) async {
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      BaseResponse baseResponse;

      baseResponse = await dataRepository.userBuyCancel(id, reason);
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

  Future<void> buyConfrim(int id) async {
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      BaseResponse baseResponse;

      baseResponse = await dataRepository.userBuyConfirm(id, "");
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

  Future<void> send(int id, String content, String type) async {
    if (type == "sale") {
      saleCancel(id, content ?? "");
    } else
      buyCancel(id, content ?? "");
  }
}
