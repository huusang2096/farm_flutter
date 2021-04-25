import 'package:farmgate/src/common/base_cubit.dart';

part 'setting_state.dart';

class SettingCubit extends BaseCubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  // ignore: always_declare_return_types
  touchFaceID() async {
    bool _isTouchFaceID = !state.isTouchFaceID;
    try {
      appPref.isEnabledBioLogin = _isTouchFaceID;
      print('_isTouchFaceID $_isTouchFaceID');
      emit(TurnTouchFaceIDState(
        isTouchFaceID: _isTouchFaceID,
        state: state,
      ));
    } catch (e) {
      handleAppError(e);
    }
  }

  // ignore: always_declare_return_types
  touchToTurnLight() async {
    bool _isTurnLight = !state.isTurnLight;
    try {
      if (state.isTurnLight == true) {
        //if true turn touch faceID ON
      } else {
        //if false turn touch faceID OFF
      }
      emit(TurnLightState(
        isTurnLight: _isTurnLight,
        state: state,
      ));
    } catch (e) {
      handleAppError(e);
    }
  }

  // ignore: always_declare_return_types
  getInfoSetting() async {
    try {
      bool _isTurnOn = await appPref.isEnabledBioLogin;
      emit(TurnTouchFaceIDState(
        isTouchFaceID: _isTurnOn,
        state: state,
      ));
    } catch (e) {
      handleAppError(e);
    }
  }

  // ignore: always_declare_return_types
  getInfoSettingDarkLight() async {
    try {
      //bool _isTurnOn =  await funcTurnLight(); //<------change
      emit(TurnLightState(
        isTurnLight: state.isTurnLight,
        state: state,
      ));
    } catch (e) {
      handleAppError(e);
    }
  }
}
