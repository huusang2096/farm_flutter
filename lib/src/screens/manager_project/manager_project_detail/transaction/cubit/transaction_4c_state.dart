part of 'transaction_4c_cubit.dart';

@freezed
abstract class Transaction4cStateData with _$Transaction4cStateData {
  const factory Transaction4cStateData(
      {bool isLoading,
      int isSelectedTypeOfProduct,
      int isSelectedMethodTransaction,
      List<MemberPartner> members,
      MemberPartner partnerSelect,
      bool isSale}) = Data;
}

@freezed
abstract class Transaction4cState with _$Transaction4cState {
  const factory Transaction4cState.initial(Data data) = Initial;
  const factory Transaction4cState.loading(Data data) = Loading;
  const factory Transaction4cState.isSelectedTypeOfProduct(Data data) =
      SelectedTypeOfProduct;
  const factory Transaction4cState.isSelectedMethodTransaction(Data data) =
      SelectedMethodTransaction;
  const factory Transaction4cState.getMemberPartner(Data data) =
      GetMemberPartner;
}
