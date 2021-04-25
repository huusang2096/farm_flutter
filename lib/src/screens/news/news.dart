import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/screens/home/home_cubit.dart';
import 'package:farmgate/src/screens/news/widget/categories_widget.dart';
import 'package:farmgate/src/screens/news/widget/orders_products.dart';
import 'package:farmgate/src/screens/search/search.dart';
import 'package:farmgate/src/screens/shimmer/news_simmer.dart';
import 'package:farmgate/src/screens/shimmer/tab_simmer.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

import 'bloc/news_cubit.dart';
import 'bloc/news_state.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends CubitState<NewsScreen, NewsCubit, NewsState>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TabController _controller;

  @override
  void initState() {
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void listener(BuildContext context, NewsState state) {
    if (state is ListCategory) {
      List<Category> categorys = state.data.categorys;
      _controller = new TabController(length: categorys.length, vsync: this)
        ..addListener(() {
          if (categorys[_controller.index].listNews.length == 0) {
            context.read<NewsCubit>().getNews(categorys[_controller.index]);
          }
        });
      context.read<NewsCubit>().getNews(categorys[0]);
    }
    if (state is ChangeIndex) {
      _controller.animateTo(state.data.indexTab);
    }
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, NewsState state) {
    List<Category> categorys = state.data.categorys;
    List<Widget> tabWidgets = [];
    List<Widget> tabWidgetViews = [];
    for (int i = 0; i < categorys.length; i++) {
      tabWidgets.add(Tab(
        child: Container(
          child: Text(
            categorys[i].name.tr,
          ),
        ),
      ));
      tabWidgetViews.add(OrdersProductsWidget(categorys[i]));
    }

    return DefaultTabController(
        initialIndex: state.data.indexTab,
        length: categorys.length,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Container(
            width: double.infinity,
            child: Drawer(child: CategoriesWidget()),
          ),
          endDrawer: Container(
            width: double.infinity,
            child: Drawer(child: SearchWidget.provider()),
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: LogoWidget(
                    urlImg: Images.logoIcon,
                    bottom: 0,
                  ),
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Colors.grey),
                  actions: <Widget>[
                    IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/loupe.svg',
                          color: Colors.grey,
                          width: 25,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        }),
                    IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/settings.svg',
                          color: Colors.grey,
                          width: 25,
                        ),
                        onPressed: () {
                          context.read<HomeCubit>().changeTab(4);
                        }),
                  ],
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(height: 1, color: Colors.grey),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.grey,
                                size: 25.0,
                              ),
                              onPressed: () {
                                _scaffoldKey.currentState.openDrawer();
                              }),
                          categorys.length != 0
                              ? Expanded(
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      controller: _controller,
                                      labelColor: tabSelect,
                                      unselectedLabelColor: Colors.grey,
                                      labelStyle: title,
                                      isScrollable: true,
                                      tabs: tabWidgets),
                                )
                              : Expanded(child: TabShimmer())
                        ],
                      ),
                    ],
                  )),
                  pinned: true,
                )
              ];
            },
            body: categorys.length != 0
                ? TabBarView(children: tabWidgetViews, controller: _controller)
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: NewsShimmer()),
          ),
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<NewsCubit>().getListCategory();
    context.read<NewsCubit>().getListHotNews();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;
}
