import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/profile/cubit/profile_cubit.dart';
import 'package:farmgate/src/screens/profile/widgets/profile_custom_row_Item.dart';
import 'package:farmgate/src/screens/profile/widgets/profile_custom_row_info.dart';
import 'package:farmgate/src/screens/profile/widgets/profile_custom_type_Item.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/empty_account.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ProfileScreen extends CubitWidget<ProfileCubit, ProfileState> {
  final _height5 = 1.0;

  ProfileCubit cubit;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void afterFirstLayout(BuildContext context) {
    cubit = context.read<ProfileCubit>();
    cubit.getProfile();
    super.afterFirstLayout(context);
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    cubit.getProfile();
    _refreshController.refreshCompleted();
  }

  @override
  void listener(BuildContext context, ProfileState state) {
    super.listener(context, state);
    if (state is LogoutSuccessState) {
      navigator.pushNamed(AppRoute.loginWithPhoneScreen);
    }
  }

  @override
  Widget builder(BuildContext context, ProfileState state) {
    Size _size = MediaQuery.of(context).size;

    return AppProgressHUB(
      inAsyncCall: state.isLoading,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: context.watch<ProfileCubit>().checkIsLogin()
                ? state.profileResponse != null
                    ? Container(
                        color: backgroundColor,
                        width: _size.width,
                        height: _size.height,
                        child: SmartRefresher(
                          controller: _refreshController,
                          header: ReloadWidget(),
                          enablePullDown: true,
                          onRefresh: _onRefresh,
                          child: ListView(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomRowInfo(),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomTypeProfile(
                                      image: 'assets/svg/qr_code.svg',
                                      title: state.userType,
                                      isPng: false,
                                      type: state.profileResponse.data.status,
                                      press: () => navigator
                                          .pushNamed(AppRoute.userType)
                                          .then((value) => {
                                                context
                                                    .read<ProfileCubit>()
                                                    .getProfile()
                                              }),
                                      onPressReasonNotApproval: () {
                                        _showModalBottomSheet(context);
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    cubit.isUseFarm()
                                        ? CustomRowItemBodyProfile(
                                            image: Images.gardenIcon,
                                            title: 'garden',
                                            isPng: false,
                                            decription: 'manger_green',
                                            press: () => navigator.pushNamed(
                                                AppRoute.farmManager),
                                          )
                                        : SizedBox.shrink(),
                                    cubit.isUseFarm()
                                        ? SizedBox(
                                            height: _height5,
                                          )
                                        : SizedBox.shrink(),
                                    cubit.isUse4c()
                                        ? CustomRowItemBodyProfile(
                                            image: Images.gardenIcon,
                                            title: '4C TRACEABILITY',
                                            decription: 'decription_4c',
                                            isPng: false,
                                            press: () => navigator.pushNamed(
                                                AppRoute.managerProject),
                                          )
                                        : SizedBox.shrink(),
                                    cubit.isUse4c()
                                        ? SizedBox(
                                            height: _height5,
                                          )
                                        : SizedBox.shrink(),
                                    CustomRowItemBodyProfile(
                                      image: Images.settingIcon,
                                      title: 'settings',
                                      decription: 'setting_decription',
                                      isPng: false,
                                      press: () => navigator
                                          .pushNamed(AppRoute.settingScreen),
                                    ),
                                    SizedBox(
                                      height: _height5,
                                    ),
                                    CustomRowItemBodyProfile(
                                      image: Images.helpIcon,
                                      title: 'help',
                                      decription: 'help_decription',
                                      isPng: false,
                                      press: () => navigator
                                          .pushNamed(AppRoute.contactScreen),
                                    ),
                                    SizedBox(
                                      height: _height5,
                                    ),
                                    CustomRowItemBodyProfile(
                                      image: Images.logoutIcon,
                                      title: 'logout',
                                      decription: '',
                                      isPng: false,
                                      press: () =>
                                          context.read<ProfileCubit>().logout(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: _size.width,
                        height: _size.height,
                        child: Center(
                            child: SpinKitCircle(
                          color: Colors.white,
                        )),
                      )
                : EmptyAccount()),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 10),
                curve: Curves.decelerate,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 60,
                            height: 5,
                          ),
                          Container(
                            width: 60,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20, top: 20),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                gradient: linearGradient,
                              ),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('reason_not_approval'.tr,
                            style: titleNew.copyWith(color: Colors.black)),
                      ),
                      SizedBox(height: 15),
                      Container(height: 5, color: backgroundColor),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          children: [
                            Text('reason 1: ...',
                                style: body1.copyWith(color: Colors.black)),
                            Text('reason 2: ...',
                                style: body1.copyWith(color: Colors.black)),
                            Text('reason 3: ...',
                                style: body1.copyWith(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
