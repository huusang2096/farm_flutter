part of 'contact_cubit.dart';

@freezed
abstract class ContactDataState with _$ContactDataState {
  const factory ContactDataState(
      {@nullable ContactResponse contactResponse,
      @Default(false) bool isLoading,
      @Default(false) bool isLoadingAddress,
      @nullable Place myPlace}) = Data;
}

@freezed
abstract class ContactState with _$ContactState {
  const factory ContactState.init(ContactDataState data) = Initial;

  const factory ContactState.loading(ContactDataState data) = Loading;

  const factory ContactState.sendContact(ContactDataState data) = SendContact;

  const factory ContactState.placeChange(ContactDataState data) = PlaceChange;
}
