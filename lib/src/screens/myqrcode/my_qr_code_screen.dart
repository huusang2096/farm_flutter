import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/myqrcode/cubit/my_qr_code_cubit.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simplest/simplest.dart';

class MyQrCodeScreen extends StatelessWidget {
  static BlocProvider<MyQrCodeCubit> provider() {
    return BlocProvider(
      create: (context) => MyQrCodeCubit(),
      child: MyQrCodeScreen(),
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final double width = 220.0;
  final double height = 220.0;
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MyQrCodeCubit>().state;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SizedBox.expand(
          child: Center(
            child: watch.data.isLoading
                ? shimmerQR()
                : watch.data?.profileResponse?.data?.id == null
                    ? SizedBox(child: Text('server_error'.tr))
                    : Container(
                        // color: Colors.white,
                        child: RepaintBoundary(
                          key: _scaffoldKey,
                          child: QrImage(
                            gapless: false,
                            backgroundColor: Colors.white,
                            data: watch.data.profileResponse.data.id.toString(),
                            version: QrVersions.auto,
                            size: width,
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Widget shimmerQR() {
    return Shimmer.fromColors(
      baseColor: greyColor300,
      highlightColor: greyColor100,
      child: Container(height: height, width: width, color: whiteColor),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: Colors.grey),
      title: Text(
        'farmer_code'.tr,
        style: headingBlack18,
      ),
      elevation: 1,
      actions: [
        IconButton(
          icon: Icon(Icons.share, color: appIconColor),
          onPressed: () =>
              context.read<MyQrCodeCubit>().captureAndSharePng(_scaffoldKey),
        )
      ],
      centerTitle: true,
    );
  }
}
