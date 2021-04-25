import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/tree_response.dart';
import 'package:farmgate/src/model/graden/tree_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
part 'tree_state.freezed.dart';

@freezed
abstract class TreeStateData with _$TreeStateData {
  const factory TreeStateData(
      {int indexTab,
      List<TreeTypes> trees,
      DateTime timeUpdate,
      TreeResponse treeResponse,
      bool isLoading,
      int idSelect,
      @nullable int idGarden,
      @nullable List<TreeList> listTree}) = Data;
}

// Union
@freezed
abstract class TreeState with _$TreeState {
  const factory TreeState.init(TreeStateData data) = Initial;
  const factory TreeState.changeIndex(TreeStateData data) = ChangeIndex;
  const factory TreeState.listTreeType(TreeStateData data) = ListTreeTypes;
  const factory TreeState.listTree(TreeStateData data) = ListTree;
  const factory TreeState.loading(TreeStateData data) = Loading;
}
