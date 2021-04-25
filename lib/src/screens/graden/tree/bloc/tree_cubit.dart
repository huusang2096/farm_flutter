import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/graden/tree_response.dart';
import 'package:farmgate/src/model/graden/tree_type_response.dart';
import 'package:farmgate/src/model/graden/tree_types.dart';

import 'tree_state.dart';

class TreeCubit extends BaseCubit<TreeState> {
  TreeCubit({int idGarden})
      : super(Initial(Data(
            idGarden: idGarden,
            indexTab: 1,
            trees: [],
            timeUpdate: DateTime.now(),
            treeResponse: null,
            isLoading: false,
            idSelect: -1)));

  changeIndex(int index) {
    emit(ChangeIndex(state.data.copyWith(indexTab: index)));
  }

  void getListTreeById(int idGarder) async {
    try {
      final response = await dataRepository.getGardenDetailResponse(idGarder);
      if (response != null) {
        final list = response.gardenDetail?.treeList ?? [];
        emit(ListTreeTypes(state.data.copyWith(listTree: list)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  getListTreeType() async {
    try {
      TreeTypeResponse response = await dataRepository.getTreeTypes();
      if (response != null) {
        List<TreeTypes> treeTypes = [];
        treeTypes.addAll(response.data);
        emit(ListTreeTypes(state.data.copyWith(trees: treeTypes)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  getListTree(TreeTypes treeTypeModel) async {
    try {
      TreeResponse response =
          await dataRepository.getListTree(treeTypeModel.id);
      if (response != null) {
        treeTypeModel.listTree.clear();
        treeTypeModel.listTree.addAll(response.data);
        state.data.trees[state.data.trees
                .indexWhere((element) => element.id == treeTypeModel.id)] =
            treeTypeModel;
        emit(ListTree(state.data
            .copyWith(timeUpdate: DateTime.now(), treeResponse: response)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  void addTreeGarden(int id, int treeID) async {
    try {
      emit(Loading(state.data.copyWith(isLoading: true, idSelect: treeID)));
      BaseResponse response = await dataRepository.addTreeGarden(id, treeID);
      if (response.error) {
        snackbarService.showSnackbar(message: response.message);
      } else {
        snackbarService.showSnackbar(message: 'Thêm cây thành công');
      }
    } catch (e) {
      handleAppError(e);
    }
    emit(Loading(state.data.copyWith(isLoading: false, idSelect: -1)));
  }
}
