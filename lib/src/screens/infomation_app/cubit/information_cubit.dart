import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/information/information.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'information_cubit.freezed.dart';
part 'information_state.dart';

class InformationCubit extends BaseCubit<InformationState> {
  InformationCubit() : super(Initial(Data(rules: [])));

  getInformation() async {
    try {
      InformationResponse response = await dataRepository.getInformation();
      if (response != null && response.data.length > 0) {
        emit(RuleData(state.data.copyWith(rules: response.data)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
