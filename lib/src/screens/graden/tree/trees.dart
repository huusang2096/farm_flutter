import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/tree_types.dart';
import 'package:farmgate/src/screens/graden/tree/widget/tree_products.dart';
import 'package:farmgate/src/screens/shimmer/tab_simmer.dart';
import 'package:farmgate/src/screens/shimmer/tree_products_shimmer.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

import 'bloc/tree_cubit.dart';
import 'bloc/tree_state.dart';

class TreeScreen extends StatefulWidget {
  final int gardenId;

  TreeScreen(this.gardenId);
  @override
  _TreeScreenState createState() => _TreeScreenState();

  static provider({int gardenId}) {
    return BlocProvider(
      create: (context) => TreeCubit(),
      child: TreeScreen(
        gardenId,
      ),
    );
  }
}

class _TreeScreenState extends CubitState<TreeScreen, TreeCubit, TreeState>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TabController _controller;

  @override
  void initState() {
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void listener(BuildContext context, TreeState state) {
    if (state is ListTreeTypes) {
      List<TreeTypes> treeTypes = state.data.trees;
      _controller = new TabController(length: treeTypes.length, vsync: this)
        ..addListener(() {
          if (treeTypes[_controller.index].listTree.length == 0) {
            context.read<TreeCubit>().getListTree(treeTypes[_controller.index]);
          }
        });
      context.read<TreeCubit>().getListTree(treeTypes[0]);
    }
    if (state is ChangeIndex) {
      _controller.animateTo(state.data.indexTab);
    }
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, TreeState state) {
    List<TreeTypes> trees = state.data.trees;
    List<Widget> tabWidgets = [];
    List<Widget> tabWidgetViews = [];
    int _gardenId = 0;
    if (widget is TreeScreen) {
      _gardenId = (widget as TreeScreen).gardenId;
    }
    for (int i = 0; i < trees.length; i++) {
      tabWidgets.add(Tab(
        child: Container(
          child: Text(
            trees[i].name.tr,
            textAlign: TextAlign.center,
          ),
        ),
      ));
      tabWidgetViews.add(TreeWidget(trees[i], _gardenId));
    }

    return DefaultTabController(
        initialIndex: state.data.indexTab,
        length: trees.length,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: trees.length != 0
              ? AppBar(
                  centerTitle: true,
                  title: LogoWidget(
                    urlImg: Images.logoIcon,
                    bottom: 0,
                  ),
                  automaticallyImplyLeading: true,
                  iconTheme: IconThemeData(color: greyColor),
                  elevation: 1.0,
                  bottom: TabBar(
                      indicatorColor: Colors.transparent,
                      controller: _controller,
                      labelColor: tabSelect,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: title,
                      isScrollable: true,
                      tabs: tabWidgets))
              : PreferredSize(
                  preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                  child: Container(
                      padding: EdgeInsets.only(top: kToolbarHeight / 2),
                      width: double.infinity,
                      child: TabShimmer())),
          body: trees.length != 0
              ? TabBarView(children: tabWidgetViews, controller: _controller)
              : SingleChildScrollView(
                  padding: EdgeInsets.all(10), child: TreeProductsShimmer()),
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<TreeCubit>().getListTreeType();
  }
}
