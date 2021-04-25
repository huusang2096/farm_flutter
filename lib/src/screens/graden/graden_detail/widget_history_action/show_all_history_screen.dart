import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_history_action/bloc/history_action_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_history_action/widget/action_history_item_widget.dart';
import 'package:farmgate/src/screens/shimmer/action_simmer.dart';
import 'package:farmgate/src/widgets/footer_widget.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

class ShowAllHistoryScreen
    extends CubitWidget<HistoryActionCubit, HistoryActionState> {
  final gardenId;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ShowAllHistoryScreen(this.gardenId);

  static provider(int gardenId) {
    return BlocProvider(
      create: (context) => HistoryActionCubit(),
      child: ShowAllHistoryScreen(gardenId),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<HistoryActionCubit>().getAllActionList(gardenId);
  }

  @override
  Widget builder(BuildContext context, HistoryActionState state) {
    void _onRefresh() async {
      context.read<HistoryActionCubit>().getAllActionList(gardenId);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      context.read<HistoryActionCubit>().getMorelActionList(gardenId);
      _refreshController.loadComplete();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: greyColor),
        title: LogoWidget(
          urlImg: Images.logoIcon,
          bottom: 0,
        ),
        elevation: 1.0,
      ),
      body: SmartRefresher(
          controller: _refreshController,
          header: ReloadWidget(),
          footer: FooterWidget(),
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SingleChildScrollView(
            child: state.data.gardenHistoryActionResponse == null
                ? ActionShimmer()
                : Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 6),
                    child: ListView.separated(
                      separatorBuilder: (context, _) => SizedBox(height: 12),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: state
                          .data.gardenHistoryActionResponse.data.data.length,
                      itemBuilder: (context, index) => ActionHistoryItemWidget(
                          state.data.gardenHistoryActionResponse.data
                              .data[index]),
                    ),
                  ),
          )),
    );
  }
}
