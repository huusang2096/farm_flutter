part of 'setting_cubit.dart';

class SettingState {
  bool isTouchFaceID;
  bool isTurnLight;
  bool isLoading;

  SettingState({this.isTouchFaceID, this.isTurnLight, this.isLoading});

  SettingState copyWith({
    bool isTouchFaceID,
    bool isTurnLight,
    bool isLoading,
  }) {
    return SettingState(
      isTouchFaceID: isTouchFaceID ?? this.isTouchFaceID,
      isTurnLight: isTurnLight ?? this.isTurnLight,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  SettingState.from({SettingState state}) {
    isTouchFaceID = state.isTouchFaceID;
    isTurnLight = state.isTurnLight;
    isLoading = state.isLoading;
  }
}

class SettingInitial extends SettingState {
  SettingInitial()
      : super(
          isTouchFaceID: true,
          isTurnLight: false,
          isLoading: false,
        );
}

class TurnTouchFaceIDState extends SettingState {
  TurnTouchFaceIDState({bool isTouchFaceID, SettingState state})
      : super.from(state: state.copyWith(isTouchFaceID: isTouchFaceID));
}

class TurnLightState extends SettingState {
  TurnLightState({bool isTurnLight, SettingState state})
      : super.from(state: state.copyWith(isTurnLight: isTurnLight));
}
