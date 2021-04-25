import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/search/search.dart';
import 'package:farmgate/src/screens/videos/bloc/video_cubit.dart';
import 'package:farmgate/src/screens/videos/widget/video_list.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

import 'bloc/video_state.dart';

class VideosScreen extends CubitWidget<VideoCubit, VideoState> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void listener(BuildContext context, VideoState state) {
    if (state is ListVideo) {
      _refreshController.refreshCompleted();
    }
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, VideoState state) {
    void _onRefresh() async {
      context.read<VideoCubit>().getListVideo();
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      context.read<VideoCubit>().getListVideo();
      _refreshController.loadComplete();
    }

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: double.infinity,
        child: Drawer(child: SearchWidget.provider()),
      ),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.grey),
        title: LogoWidget(
          urlImg: Images.logoIcon,
          bottom: 0,
        ),
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
        ],
      ),
      body: SmartRefresher(
          controller: _refreshController,
          header: ReloadWidget(),
          enablePullDown: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SingleChildScrollView(child: VideoList())),
    );
  }
}
