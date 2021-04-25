import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/plant_protect/plant_protection_types_response.dart';
import 'package:farmgate/src/screens/graden/plantprotect/blocs/protect_cubit.dart';
import 'package:farmgate/src/screens/graden/plantprotect/blocs/protect_state.dart';
import 'package:farmgate/src/screens/graden/plantprotect/widget/plan_products.dart';
import 'package:farmgate/src/screens/shimmer/tab_simmer.dart';
import 'package:farmgate/src/screens/shimmer/tree_products_shimmer.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

class ProtectProductScreen extends StatefulWidget {
  final int gardenId;
  final ActionGarden actionGarden;

  ProtectProductScreen(this.gardenId, this.actionGarden);

  @override
  _ProtectProductScreenState createState() => _ProtectProductScreenState();

  static provider({int gardenId, ActionGarden actionGarden}) {
    return BlocProvider(
      create: (context) => ProtectCubit(),
      child: ProtectProductScreen(gardenId, actionGarden),
    );
  }
}

class _ProtectProductScreenState
    extends CubitState<ProtectProductScreen, ProtectCubit, ProtectState>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TabController _controller;

  @override
  void initState() {
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void listener(BuildContext context, ProtectState state) {
    if (state is LoadedListPlantType) {
      List<PlantProtectionTypes> plantProtectionTypes =
          state.data.plantProtectionTypes;
      _controller = new TabController(
          length: plantProtectionTypes.length, vsync: this)
        ..addListener(() {
          if (plantProtectionTypes[_controller.index].plantProtects.length ==
              0) {
            context
                .read<ProtectCubit>()
                .getListPlantProtect(plantProtectionTypes[_controller.index]);
          }
        });
      context.read<ProtectCubit>().getListPlantProtect(plantProtectionTypes[0]);
    }
    if (state is ChangeIndex) {
      _controller.animateTo(state.data.indexTab);
    }
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, ProtectState state) {
    List<PlantProtectionTypes> plantProtectionTypes =
        state.data.plantProtectionTypes;
    List<Widget> tabWidgets = [];
    List<Widget> tabWidgetViews = [];
    int _gardenId = 0;
    ActionGarden actionGarden;
    if (widget is ProtectProductScreen) {
      _gardenId = (widget as ProtectProductScreen).gardenId;
      actionGarden = (widget as ProtectProductScreen).actionGarden;
    }
    for (int i = 0; i < plantProtectionTypes.length; i++) {
      tabWidgets.add(Tab(
        child: Container(
          child: Text(
            plantProtectionTypes[i].name.tr,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ));
      tabWidgetViews.add(
          PlanProductWidget(plantProtectionTypes[i], _gardenId, actionGarden));
    }

    return DefaultTabController(
        initialIndex: state.data.indexTab,
        length: plantProtectionTypes.length,
        child: Scaffold(
          backgroundColor: backgroundColor,
          key: _scaffoldKey,
          appBar: plantProtectionTypes.length != 0
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
          body: plantProtectionTypes.length != 0
              ? TabBarView(children: tabWidgetViews, controller: _controller)
              : SingleChildScrollView(
                  padding: EdgeInsets.all(10), child: TreeProductsShimmer()),
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ProtectCubit>().getListPlanProtectType();
  }
}
