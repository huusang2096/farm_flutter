import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/storage/app_prefs.dart';
import 'package:farmgate/src/screens/home/home_cubit.dart';
import 'package:farmgate/src/screens/news/bloc/news_cubit.dart';
import 'package:farmgate/src/screens/news/news.dart';
import 'package:farmgate/src/screens/profile/cubit/profile_cubit.dart';
import 'package:farmgate/src/screens/profile/profile_screen.dart';
import 'package:farmgate/src/screens/report/cubit/report_cubit.dart';
import 'package:farmgate/src/screens/report/my_report.dart';
import 'package:farmgate/src/screens/share/bloc/share_cubit.dart';
import 'package:farmgate/src/screens/share/share.dart';
import 'package:farmgate/src/screens/videos/bloc/video_cubit.dart';
import 'package:farmgate/src/screens/videos/videos.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import '../../../locator.dart';
import 'home_state.dart';

class HomeScreen extends CubitWidget<HomeCubit, HomeState> {
  final _appPref = locator<AppPref>();
  Widget currentPage = NewsScreen();
  List<Widget> screens = [
    ReportScreen(),
    NewsScreen(),
    VideosScreen(),
    ShareScreen(),
    ProfileScreen()
  ];

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<HomeCubit>().setup();
  }

  static provider() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
        BlocProvider(
          create: (context) => VideoCubit(),
        ),
        BlocProvider(
          create: (context) => ShareCubit(),
        ),
        BlocProvider(
          create: (context) => ReportCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: HomeScreen(),
    );
  }

  @override
  void listener(BuildContext context, HomeState state) {
    if (state is UpdateUser) {
      BlocProvider.of<ProfileCubit>(context).getProfile();
    }
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, HomeState state) {
    VideoCubit videoCubit = BlocProvider.of<VideoCubit>(context);
    ShareCubit shareCubit = BlocProvider.of<ShareCubit>(context);
    ReportCubit reportCubit = BlocProvider.of<ReportCubit>(context);

    void _selectTab(int tabItem) {
      switch (tabItem) {
        case 0:
          reportCubit.getMyReport();
          context.read<HomeCubit>().changeTab(0);
          break;
        case 1:
          context.read<HomeCubit>().changeTab(1);
          break;
        case 2:
          if (videoCubit.state.data.listVideos.length == 0) {
            videoCubit.getListVideo();
          }
          context.read<HomeCubit>().changeTab(2);
          break;
        case 3:
          if (shareCubit.state.data.listShares.length == 0) {
            shareCubit.getListShare();
          }
          context.read<HomeCubit>().changeTab(3);
          break;
        case 4:
          context.read<HomeCubit>().changeTab(4);
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: state.data.indexTab,
        children: screens,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 4.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: state.data.indexTab,
          backgroundColor: Colors.white,
          selectedItemColor: appBarColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: caption,
          unselectedLabelStyle: caption,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          onTap: (int i) {
            _selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/statistics.svg',
                width: 25,
                height: 25,
                color: state.data.indexTab == 0 ? appBarColor : Colors.grey,
              ),
              label: 'report'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/newspaper.svg',
                width: 25,
                height: 25,
                color: state.data.indexTab == 1 ? appBarColor : Colors.grey,
              ),
              label: 'news'.tr,
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/video_call.svg',
                  width: 25,
                  height: 25,
                  color: state.data.indexTab == 2 ? appBarColor : Colors.grey,
                ),
                label: 'video'.tr),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/business_meeting.svg',
                  width: 25,
                  height: 25,
                  color: state.data.indexTab == 3 ? appBarColor : Colors.grey,
                ),
                label: 'share'.tr),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/user.svg',
                  width: 25,
                  height: 25,
                  color: state.data.indexTab == 4 ? appBarColor : Colors.grey,
                ),
                label: 'profile'.tr),
          ],
        ),
      ),
    );
  }
}
