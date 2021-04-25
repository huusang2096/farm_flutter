part of 'user_type_cubit.dart';

@freezed
abstract class UserTypeData with _$UserTypeData {
  const factory UserTypeData({
    @Default(false) bool isLoading,
    @nullable UserTypeModel userTypeModel,
    @nullable File imgIDBefore,
    @nullable File imgIDAfter,
    @nullable File imgBusiness,
    @nullable String ID,
    @nullable String IDBusiness,
    @Default(false) bool isUpload,
  }) = DataUserType;
}

// Union
@freezed
abstract class UserTypeState with _$UserTypeState {
  const factory UserTypeState.init(DataUserType data) = Initial;
  const factory UserTypeState.loaded(DataUserType data) = Loaded;
  const factory UserTypeState.loading(DataUserType data) = Loading;
  const factory UserTypeState.change(DataUserType data) = ChangeTye;
  const factory UserTypeState.uploadImage(DataUserType data) = UploadImage;
}
