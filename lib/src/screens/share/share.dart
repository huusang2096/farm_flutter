import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/screens/news/widget/item_gallery_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_hot_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_video_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_widget.dart';
import 'package:farmgate/src/screens/search/search.dart';
import 'package:farmgate/src/screens/share/bloc/share_cubit.dart';
import 'package:farmgate/src/screens/shimmer/news_simmer.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

import 'bloc/share_state.dart';

class ShareScreen extends CubitWidget<ShareCubit, ShareState> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void listener(BuildContext context, ShareState state) {
    // TODO: implement listener
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, ShareState state) {
    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      context.read<ShareCubit>().getListShare();
      _refreshController.refreshCompleted();
    }

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: double.infinity,
        child: Drawer(child: SearchWidget.provider()),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.grey),
        title: LogoWidget(
          urlImg: Images.logoIcon,
          bottom: 0,
        ),
        centerTitle: true,
        elevation: 1,
        actions: <Widget>[
          IconButton(
              icon: SvgPicture.asset(
                'assets/images/loupe.svg',
                color: Colors.grey,
                width: 25,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              }),
          IconButton(
              icon: SvgPicture.asset(
                'assets/images/writing.svg',
                color: Colors.grey,
                width: 25,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoute.addNewScreen);
              }),
        ],
      ),
      body: SmartRefresher(
          controller: _refreshController,
          header: ReloadWidget(),
          enablePullDown: true,
          onRefresh: _onRefresh,
          child: Container(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: state.data.listShares.length == 0
                    ? NewsShimmer()
                    : Column(
                        children: [
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.data.listShares.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 4);
                            },
                            itemBuilder: (context, index) {
                              News news =
                                  state.data.listShares.elementAt(index);
                              if (index == 0) {
                                return ItemHotWidget(news: news);
                              } else if (news.formatType == null) {
                                return ItemWidget(
                                    herotag: getRandomString(20), news: news);
                              } else if (news.formatType == 'video') {
                                return ItemVideoWidget(
                                    herotag: getRandomString(20), news: news);
                              } else if (news.formatType == 'gallery') {
                                return ItemGalleryWidget(
                                    herotag: getRandomString(20), news: news);
                              }
                            },
                          ),
                        ],
                      )),
          )),
    );
  }
}
