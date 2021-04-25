import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/graden/garden_history_action_response.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_garden_state.freezed.dart';

@freezed
abstract class GardenDetailStateData with _$GardenDetailStateData {
  const factory GardenDetailStateData(
      {GardenDetailResponse detail,
      bool showDeleteOrEdit,
      @Default(false) bool isLoadingScaffold,
      bool loadingHistory,
      List<ActionGarden> listActionGarden,
      ActionGarden productPlan,
      List<HistoryActionModel> shortListAction,
      bool isExpaned}) = DataGardenDetail;
}

// Union
@freezed
abstract class GardenDetailState with _$GardenDetailState {
  const factory GardenDetailState.init(GardenDetailStateData data) = Initial;
  const factory GardenDetailState.detail(GardenDetailStateData data) =
      GardenDetailData;
  const factory GardenDetailState.getListGardenAction(
      GardenDetailStateData data) = GardenActionData;
  const factory GardenDetailState.getListHistory(GardenDetailStateData data) =
      GardenHistory;
  const factory GardenDetailState.expaned(GardenDetailStateData data) =
      GardenExpaned;
}
