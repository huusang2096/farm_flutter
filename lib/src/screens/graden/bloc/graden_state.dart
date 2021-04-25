import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'graden_state.freezed.dart';

@freezed
abstract class GradenStateData with _$GradenStateData {
  const factory GradenStateData({
    List<MyGarden> myGarden,
    bool isGardenMap,
    bool isLoadingScaffold,
    double pinPillPosition,
    MyGarden currentlySelectedPin,
  }) = Data;
}

// Union
@freezed
abstract class GradenState with _$GradenState {
  const factory GradenState.init(GradenStateData data) = Initial;
  const factory GradenState.listCategory(GradenStateData data) = ListGraden;
  const factory GradenState.changeGarden(GradenStateData data) = GradenMap;
  const factory GradenState.loadingGarden(GradenStateData data) = GradenLoading;
  const factory GradenState.updatePinPillPosition(GradenStateData data) =
      UpdatePinPillPosition;
}
