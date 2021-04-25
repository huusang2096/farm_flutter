import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/manager_project/history_project.dart';
import 'package:farmgate/src/model/manager_project/my_project_response.dart';
import 'package:farmgate/src/screens/manager_project/manager_project_detail/cubit/manager_project_detail_cubit.dart';
import 'package:farmgate/src/screens/manager_project/manager_project_detail/widgets/separator_widget.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ManagerProjectDetailScreen
    extends CubitWidget<ManagerProjectDetailCubit, ManagerProjectDetailState> {
  final Project project;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ManagerProjectDetailScreen({this.project});

  static provider({Project project}) {
    return BlocProvider(
      create: (_) => ManagerProjectDetailCubit(),
      child: ManagerProjectDetailScreen(project: project),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ManagerProjectDetailCubit>().getHistory(project.id);
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, ManagerProjectDetailState state) {
    void _onRefresh() async {
      context.read<ManagerProjectDetailCubit>().getHistory(project.id);
      _refreshController.refreshCompleted();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      bottomNavigationBar:
          (state.data.user != null && state.data.user.permission != 5)
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: FlatButton(
                      onPressed: () {
                        navigator.pushNamed(AppRoute.transaction4cScreen,
                            arguments: {
                              'project': project
                            }).then((value) => {
                              context
                                  .read<ManagerProjectDetailCubit>()
                                  .getHistory(project.id)
                            });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            color: appIconColor,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          'new_transaction'.tr,
                          style: title.copyWith(color: Colors.white),
                        ),
                      )))
              : SizedBox.shrink(),
      body: SafeArea(
        child: SmartRefresher(
          controller: _refreshController,
          header: ReloadWidget(),
          enablePullDown: true,
          onRefresh: _onRefresh,
          child: _buildBodyContent(context, state),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: greyColor),
      elevation: 1.0,
      title: Text(
        'manager_project_detail'.tr,
        style: headingBlack18,
      ),
      centerTitle: true,
    );
  }

  Widget _buildBodyContent(
      BuildContext context, ManagerProjectDetailState state) {
    return SingleChildScrollView(
      primary: true,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${'project'.tr}${project.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: titleNew.copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Text(
                        project.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: descNew.copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            'project_address'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: descNew.copyWith(color: beginGradientColor),
                          ),
                          Flexible(
                            flex: 1,
                            child: AutoSizeText(
                              project.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: descNew,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            'join_date'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: descNew.copyWith(color: beginGradientColor),
                          ),
                          Flexible(
                            flex: 1,
                            child: AutoSizeText(
                              fullDateFormatter
                                  .format(DateTime.parse(project.createdAt)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: descNew,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            'total_transaction'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: descNew.copyWith(color: beginGradientColor),
                          ),
                          Flexible(
                            flex: 1,
                            child: AutoSizeText(
                              state.data.historyTransaction == null
                                  ? '0'
                                  : state.data.historyTransaction.length
                                      .toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: descNew,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'history_deployment'.tr,
                    style: titleNew,
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ),
          _buildListView(
              context, state, context.read<ManagerProjectDetailCubit>()),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, ManagerProjectDetailState state,
      ManagerProjectDetailCubit cubit) {
    return state.data.historyTransaction == null
        ? Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.grey,
                                  Colors.grey.withOpacity(0.1),
                                ])),
                        child: SvgPicture.asset(
                          'assets/images/history.svg',
                          color: beginGradientColor,
                          height: 30,
                          width: 30,
                        )),
                    Positioned(
                      right: -30,
                      bottom: -50,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(150),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -20,
                      top: -50,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300].withOpacity(0.15),
                          borderRadius: BorderRadius.circular(150),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'empty_history_project'.tr,
                  style: textInput,
                ),
              ],
            ),
          )
        : Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                HistoryTransaction item =
                    state.data.historyTransaction.elementAt(index);

                String title = '${'transaction'.tr}${item.typeSale.tr}';
                if (item.transactionType == 'buy' &&
                    item.typeSale == 'sell'.tr) {
                  title = '${'transaction'.tr}${'buy'.tr}';
                }

                Color colorItem = appIconColor;
                if (item.status == 'pending') {
                  colorItem = appIconColor;
                } else if (item.status == "cancel") {
                  colorItem = Colors.red;
                } else {
                  colorItem = Colors.green;
                }

                return InkWell(
                  onTap: () {
                    navigator.pushNamed(AppRoute.confirmTransactionScreen,
                        arguments: {
                          'requestID': item.id
                        }).then((value) => {cubit.getHistory(project.id)});
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: headingBlack18.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_sharp,
                                  color: beginGradientColor,
                                  size: 20,
                                ),
                                SizedBox(width: 2),
                                Text(fullDateFormatter.format(item.dateSale)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.box,
                                    color: beginGradientColor,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: AutoSizeText(
                                      '${'sectors'.tr}${item.typeGoods}',
                                      maxLines: 1,
                                      style: textInput,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                                item.transactionType == 'sale'
                                    ? " + " +
                                        currencyformatterSymbol.format(
                                            double.parse(item.totalMoney))
                                    : " - " +
                                        currencyformatterSymbol.format(
                                            double.parse(item.totalMoney)),
                                style: textInput.copyWith(
                                  color: item.transactionType == 'sale'
                                      ? Colors.green
                                      : Colors.red,
                                )),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              FontAwesomeIcons.exchangeAlt,
                              color: colorItem,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: AutoSizeText(
                                item.status.tr,
                                maxLines: 1,
                                style: textInput.copyWith(color: colorItem),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, _) => SeparatorWidget(),
              itemCount: state.data.historyTransaction.length,
            ),
          );
  }
}
