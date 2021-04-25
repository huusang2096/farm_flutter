import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/report/my_report.dart';

import 'report_state.dart';

class ReportCubit extends BaseCubit<ReportState> {
  ReportCubit()
      : super(Initial(Data(myReport: null, timeCheck: new DateTime.now())));

  bool checkIsLogin() {
    final check = appPref.token.isEmpty ? false : true;
    return check;
  }

  getMyReport() async {
    if (!checkIsLogin()) {
      emit(GetMyReport(state.data.copyWith(timeCheck: new DateTime.now())));
      return;
    }
    try {
      MyReport myReport = state.data.myReport;
      MyReportResponse response = await dataRepository.getMyReport();
      if (response != null) {
        myReport = response.data;
        emit(GetMyReport(state.data.copyWith(myReport: myReport)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
