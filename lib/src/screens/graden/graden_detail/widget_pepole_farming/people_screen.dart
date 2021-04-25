import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/status_common.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_pepole_farming/bloc/people_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_pepole_farming/widget/people_farming_widget.dart';
import 'package:farmgate/src/widgets/footer_widget.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

class AllPeopleScreen extends CubitWidget<PeopleCubit, PeopleState> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isDelete = true;
  GardenDetail graden;

  AllPeopleScreen(this.isDelete, this.graden);

  static provider(bool isDelete, GardenDetail graden) {
    return BlocProvider(
      create: (context) => PeopleCubit(),
      child: AllPeopleScreen(isDelete, graden),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<PeopleCubit>().getAllPepole();
  }

  @override
  Widget builder(BuildContext context, PeopleState state) {
    void _onRefresh() async {
      context.read<PeopleCubit>().getAllPepole();
      _refreshController.refreshCompleted();
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
        onRefresh: _onRefresh,
        child: PepoleFarmingWidget(
          status: StatusAddMember.IS_PEOPLE,
          isDelete: isDelete,
          gradenID: graden,
        ),
      ),
    );
  }
}
