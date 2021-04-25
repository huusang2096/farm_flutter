import 'package:farmgate/src/model/news/news_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_state.freezed.dart';

@freezed
abstract class ShareStateData with _$ShareStateData {
  const factory ShareStateData({List<News> listShares}) = Data;
}

// Union
@freezed
abstract class ShareState with _$ShareState {
  const factory ShareState.init(ShareStateData data) = Initial;
  const factory ShareState.listShare(ShareStateData data) = ListShare;
}
