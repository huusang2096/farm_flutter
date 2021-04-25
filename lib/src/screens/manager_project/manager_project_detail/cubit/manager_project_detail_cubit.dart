import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/manager_project/history_project.dart';
import 'package:farmgate/src/model/profile/profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_project_detail_cubit.freezed.dart';
part 'manager_project_detail_state.dart';

class ManagerProjectDetailCubit extends BaseCubit<ManagerProjectDetailState> {
  ManagerProjectDetailCubit()
      : super(Initial(
            Data(isLoading: false, historyTransaction: null, user: null)));

  @override
  Future<void> initData() async {
    Profile user = await appPref.getUser().data;
    emit(User(state.data.copyWith(user: user)));
    return super.initData();
  }

  Future<void> getHistory(int project) async {
    HistoryTransactionProject historyTransactionProject;
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      historyTransactionProject =
          await dataRepository.getHistoryTransactionProject(project.toString());
      if (historyTransactionProject == null ||
          historyTransactionProject.data.length == 0) {
        emit(Loading(
            state.data.copyWith(historyTransaction: null, isLoading: false)));
      } else {
        emit(Loading(state.data.copyWith(
            historyTransaction: historyTransactionProject.data,
            isLoading: false)));
      }
    } catch (e) {
      emit(Loading(state.data.copyWith(isLoading: true)));
      handleAppError(e);
    }
  }
}
