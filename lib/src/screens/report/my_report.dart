import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/report/my_report.dart';
import 'package:farmgate/src/screens/report/cubit/report_state.dart';
import 'package:farmgate/src/screens/report/widget/latest_fertilization_widget.dart';
import 'package:farmgate/src/screens/report/widget/total_post_widget.dart';
import 'package:farmgate/src/screens/shimmer/report_simmer.dart';
import 'package:farmgate/src/widgets/empty_account.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'cubit/report_cubit.dart';

class ReportScreen extends CubitWidget<ReportCubit, ReportState> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget builder(BuildContext context, ReportState state) {
    final Size size = MediaQuery.of(context).size;

    void _onRefresh() async {
      context.read<ReportCubit>().getMyReport();
      _refreshController.refreshCompleted();
    }

    _buttonMyGarden() {
      return FlatButton(
          onPressed: () {
            navigator.pushNamed(AppRoute.myGardenScreen);
          },
          child: Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: totalPostColor, borderRadius: BorderRadius.circular(80)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/farming.png',
                  color: Colors.white,
                  width: 50,
                  height: 50,
                ),
                Text(
                  'my_garden'.tr,
                  style: body1.copyWith(color: Colors.white),
                ),
              ],
            ),
          ));
    }

    Widget myReport(MyReport myReport) {
      return Container(
        height: MediaQuery.of(context).size.height,
        color: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            TotalPostWidget(totalPosts: myReport.totalPosts, height: 150),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LatestFertilizationWidget(
                      height: 120,
                      title: 'latest_manure_date'.tr,
                      iconLeft: 'assets/images/water_droplet.svg',
                      date: myReport.latestManureDate ?? 'updating'.tr),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LatestFertilizationWidget(
                      height: 120,
                      title: 'latest_spray_date'.tr,
                      iconLeft: 'assets/images/fertilizer.svg',
                      date: myReport.latestSprayDate ?? 'updating'.tr),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buttonMyGarden(),
          ],
        ),
      );
    }

    return context.watch<ReportCubit>().checkIsLogin()
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(color: greyColor),
              title: LogoWidget(
                urlImg: Images.logoIcon,
                bottom: 0,
              ),
              elevation: 1,
            ),
            body: SmartRefresher(
              controller: _refreshController,
              header: ReloadWidget(),
              enablePullDown: true,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                child: state.data.myReport == null
                    ? ReportShimmer(size: size)
                    : myReport(state.data.myReport),
              ),
            ),
          )
        : EmptyAccount();
  }
}
