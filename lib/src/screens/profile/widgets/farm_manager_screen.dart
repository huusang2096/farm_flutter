import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/screens/profile/widgets/profile_custom_row_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class FarmManagerScreen extends StatelessWidget {
  final paddingTL = 20.0;
  final _height5 = 5.0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Container(
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
                    'garden'.tr,
                    style: TextStyle(color: greyColor),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CustomRowItemBodyProfile(
                  image: 'assets/svg/qr_code.svg',
                  title: 'farmer_code',
                  decription: '',
                  isPng: false,
                  press: () => navigator.pushNamed(AppRoute.myQrCodeScreen),
                ),
                //invisible people
                // SizedBox(
                //   height: _height5,
                // ),
                // CustomRowItemBodyProfile(
                //   image: 'assets/images/group.svg',
                //   title: 'people',
                //   isPng: false,
                //   decription: '',
                //   press: () => navigator.pushNamed(AppRoute.allPeople,
                //       arguments: {'isDelete': true, 'garden': null}),
                // ),
                SizedBox(
                  height: _height5,
                ),
                CustomRowItemBodyProfile(
                  image: Images.gardenIcon,
                  title: 'list_garden',
                  isPng: false,
                  decription: '',
                  press: () => navigator.pushNamed(AppRoute.myGardenScreen),
                ),
                SizedBox(
                  height: _height5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
