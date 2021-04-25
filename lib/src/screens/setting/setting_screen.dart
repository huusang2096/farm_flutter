import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/screens/setting/cubit/setting_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class SettingScreen extends CubitWidget<SettingCubit, SettingState> {
  final paddingTL = 20.0;
  bool isCheckInfo = false;
  bool isTurnLight = false;

  static BlocProvider<SettingCubit> provider() {
    return BlocProvider<SettingCubit>(
      create: (context) => SettingCubit(),
      child: SettingScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    context.read<SettingCubit>().getInfoSetting();
    context.read<SettingCubit>().getInfoSettingDarkLight();
  }

  @override
  void listener(BuildContext context, SettingState state) {
    super.listener(context, state);
    if (state is TurnTouchFaceIDState) {
      isCheckInfo = state.isTouchFaceID;
    }
    if (state is TurnLightState) {
      isTurnLight = state.isTurnLight;
    }
  }

  @override
  Widget builder(BuildContext context, SettingState state) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Container(
          height: _size.height,
          width: _size.width,
          color: greyColor300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingTL,
                  ),
                  child: Text(
                    'security'.tr,
                    style: TextStyle(color: greyColor),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    navigator.pushNamed(AppRoute.changePasswordScreen);
                  },
                  child: Container(
                    color: whiteColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingTL, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lock_rounded,
                                color: appIconColor,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'change_password'.tr,
                                style: TextStyle(
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_right_sharp,
                            color: greyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingTL,
                  ),
                  child: Text(
                    'setting_app'.tr,
                    style: TextStyle(color: greyColor),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    navigator.pushNamed(AppRoute.languagesScreen);
                  },
                  child: Container(
                    color: whiteColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingTL, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.language,
                                color: appIconColor,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'languages'.tr,
                                style: TextStyle(
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_right_sharp,
                            color: greyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    navigator.pushNamed(AppRoute.informationAppScreen);
                  },
                  child: Container(
                    color: whiteColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingTL, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'app_info'.tr,
                            style: TextStyle(
                              color: greyColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_sharp,
                            color: greyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        'settings'.tr,
        style: headingBlack18,
      ),
      centerTitle: true,
    );
  }
}
