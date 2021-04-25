import 'dart:async';

import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_state.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/image_tree_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/map_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/tree_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/action_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/actiontype_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_history_action/action_history_widget.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:simplest/simplest.dart';

import 'bloc/detail_garden_cubit.dart';

class GardenDetailWidget extends StatefulWidget {
  final int id;
  String img;
  final String heroTag;
  final MyGarden data;

  GardenDetailWidget(this.id, this.heroTag, this.img, this.data);

  static provider({int id, String img, String herotag, MyGarden data}) {
    return BlocProvider(
      create: (context) => GardenDetailCubit(),
      child: GardenDetailWidget(id, herotag, img, data),
    );
  }

  @override
  _GardenDetailState createState() => _GardenDetailState();
}

class _GardenDetailState
    extends CubitState<GardenDetailWidget, GardenDetailCubit, GardenDetailState>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AutoScrollController _autoScrollController;
  final scrollDirection = Axis.vertical;
  TabController _tabController;
  bool isTabIndex = false;
  int index = 0;
  GardenDetailCubit cubit;

  @override
  void initState() {
    cubit = context.read<GardenDetailCubit>();
    cubit.getGardenDetail(currentWidget.id);
    cubit.getShortActionHistory(currentWidget.id);
    cubit.getListActionType();

    //invisible people so maxScrollVal from 6 -> 5
    _tabController = TabController(vsync: this, length: 5);
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    );
    _autoScrollController.addListener(() {
      if (_autoScrollController.offset > (160 - kToolbarHeight) &&
          _autoScrollController.offset < 400) {
        cubit.changeExpaned(false);
      } else if (_autoScrollController.offset < (160 - kToolbarHeight)) {
        cubit.changeExpaned(true);
      }
      final maxScrollVal = _autoScrollController.position.maxScrollExtent;
      //invisible people so maxScrollVal from 6 -> 5
      final divisor = maxScrollVal / 5;
      final scrollValue = _autoScrollController.offset.round();
      final slideValue = (scrollValue / divisor).round();
      if (slideValue < 6 && slideValue >= 1 && !isTabIndex) {
        _tabController.animateTo(slideValue - 1);
      }
    });
  }

  Widget _buildHeader(state) {
    GardenDetailResponse data = state.data.detail;
    return Stack(
      children: [
        Hero(
          tag: currentWidget.heroTag,
          child: ImageNetWork(
              width: double.infinity,
              height: 400,
              borderRadius: 8,
              imgUrl: currentWidget.img),
        ),
        Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: data != null
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.gardenDetail.name,
                                    textAlign: TextAlign.left,
                                    style: titleNew.copyWith(
                                        color: Colors.white, fontSize: 20)),
                                Text(data.gardenDetail.description,
                                    textAlign: TextAlign.left,
                                    style:
                                        descNew.copyWith(color: Colors.white)),
                              ],
                            ),
                          )
                        : Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                              ],
                            ))),
              ],
            ))
      ],
    );
  }

  Future _scrollToIndex(int index, state) async {
    isTabIndex = true;
    await _autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    _autoScrollController.highlight(index);
    isTabIndex = false;
  }

  Widget _wrapScrollTag({int index, Widget child, state}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: child,
      highlightColor: appIconColor.withOpacity(0.5),
    );
  }

  Widget _buildSliverAppbar(GardenDetailState state) {
    return SliverAppBar(
      brightness: Brightness.light,
      iconTheme: IconThemeData(
          color: state.data.isExpaned ? Colors.white : Colors.grey),
      pinned: true,
      expandedHeight: 300,
      centerTitle: true,
      title: state.data.isExpaned
          ? SizedBox.shrink()
          : Text(
              state.data.detail != null
                  ? state.data.detail.gardenDetail.name
                  : "",
              textAlign: TextAlign.left,
              style: titleNew.copyWith(color: Colors.black, fontSize: 20)),
      flexibleSpace:
          Container(child: FlexibleSpaceBar(background: _buildHeader(state))),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: state.data.isExpaned ? 0.0 : 1,
          child: DefaultTabController(
            length: 5,
            child: Container(
              height: 36,
              child: TabBar(
                indicatorColor: Colors.transparent,
                controller: _tabController,
                labelColor: tabSelect,
                unselectedLabelColor: Colors.grey,
                labelStyle: title,
                isScrollable: true,
                onTap: (index) async {
                  _scrollToIndex(index, state);
                },
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'image_tree'.tr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'tree'.tr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'area'.tr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'action'.tr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'history_action'.tr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen(GardenDetailState state) {
    GardenDetailResponse data = state.data.detail;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        controller: _autoScrollController,
        slivers: <Widget>[
          _buildSliverAppbar(state),
          SliverList(
              delegate: SliverChildListDelegate([
            _wrapScrollTag(
                index: 0,
                child: ImageTreeWidget(
                  imageSelect: (url) {
                    setState(() {
                      currentWidget.img = url;
                    });
                  },
                )),
            SizedBox(height: 10),
            _wrapScrollTag(
                index: 1,
                child:
                    ListTreeWidget(state.data?.detail?.gardenDetail?.id ?? 0)),
            SizedBox(height: 10),
            _wrapScrollTag(
                index: 2,
                child: IgnorePointer(child: MapWidget(currentWidget.data))),
            SizedBox(height: 10),
            _wrapScrollTag(
                index: 3,
                child: Container(
                  height: 550,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16),
                      Text(
                        'action'.tr,
                        style: titleNew,
                      ),
                      Expanded(
                        child: ActionWidget(
                          onSelectAction: (actionGarden) {
                            if (actionGarden.type == "protected") {
                              Navigator.of(context).pushNamed(
                                  AppRoute.listPlant,
                                  arguments: {
                                    'idGarden': currentWidget.id,
                                    'action_type': actionGarden
                                  }).then((value) => {
                                    cubit
                                        .getShortActionHistory(currentWidget.id)
                                  });
                            } else {
                              _showActionType(actionGarden, currentWidget.id);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(height: 10),
            _wrapScrollTag(
                index: 4,
                child: Container(
                  height: 450,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'history_action'.tr,
                            style: titleNew,
                          ),
                          GestureDetector(
                            onTap: () {
                              navigator.pushNamed(AppRoute.showAllHistoryScreen,
                                  arguments: {'gardenId': currentWidget.id});
                            },
                            child: Row(
                              children: [
                                Text(
                                  'view_all'.tr,
                                  style: TextStyle(color: appIconColor),
                                ),
                                SizedBox(
                                  width: 2.0,
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  color: appIconColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ActionHistoryWidget(),
                      ),
                    ],
                  ),
                ))
          ])),
        ],
      ),
    );
  }

  Future<Widget> _showActionType(ActionGarden actionGarden, int id) async {
    await showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.decelerate,
                  child: ActionTypeWidget.provider(
                      action: actionGarden, gardenId: id));
            },
          );
        });
    cubit.getShortActionHistory(currentWidget.id);
  }

  @override
  Widget builder(BuildContext context, GardenDetailState state) {
    return AppProgressHUB(
        inAsyncCall: state.data.isLoadingScaffold,
        child: Scaffold(key: _scaffoldKey, body: _buildScreen(state)));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _autoScrollController.dispose();
  }

  @override
  void listener(BuildContext context, GardenDetailState state) {
    // TODO: implement listener
    super.listener(context, state);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }
}
