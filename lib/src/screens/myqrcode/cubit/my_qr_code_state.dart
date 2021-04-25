part of 'my_qr_code_cubit.dart';

@freezed
abstract class MyQrCodeData with _$MyQrCodeData {
  const factory MyQrCodeData(
      {@Default(true) bool isLoading,
      @nullable ProfileResponse profileResponse}) = DataQRCode;
}

// Union
@freezed
abstract class MyQrCodeState with _$MyQrCodeState {
  const factory MyQrCodeState.init(DataQRCode data) = Initial;
  const factory MyQrCodeState.loaded(DataQRCode data) = Loaded;
  const factory MyQrCodeState.loading(DataQRCode data) = Loading;
}
