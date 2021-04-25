import 'package:farmgate/src/model/report/my_report.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_state.freezed.dart';

@freezed
abstract class ReportStateData with _$ReportStateData {
  const factory ReportStateData({MyReport myReport, DateTime timeCheck}) = Data;
}

// Union
@freezed
abstract class ReportState with _$ReportState {
  const factory ReportState.init(ReportStateData data) = Initial;
  const factory ReportState.myReport(ReportStateData data) = GetMyReport;
}
