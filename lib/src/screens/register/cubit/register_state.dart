part of 'register_cubit.dart';

@freezed
abstract class RegisterData with _$RegisterData {
  const factory RegisterData({@Default(false) bool isLoading}) = DataRegister;
}

// Union
@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState.init(DataRegister data) = Initial;
  const factory RegisterState.loaded(DataRegister data) = Loaded;
  const factory RegisterState.loading(DataRegister data) = Loading;
}
