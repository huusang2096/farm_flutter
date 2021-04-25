part of 'confirm_transaction_cubit.dart';

@freezed
abstract class ConfirmTransactionStateData with _$ConfirmTransactionStateData {
  const factory ConfirmTransactionStateData(
      {bool isLoading, HistoryTransaction historyTransaction}) = Data;
}

@freezed
abstract class ConfirmTransactionState with _$ConfirmTransactionState {
  const factory ConfirmTransactionState.initial(Data data) = Initial;
  const factory ConfirmTransactionState.loading(Data data) = Loading;
  const factory ConfirmTransactionState.createTransactionSuccess(Data data) =
      CreateTransactionSuccess;
  const factory ConfirmTransactionState.getHistory(Data data) =
      GetHistoryTransaction;
}
