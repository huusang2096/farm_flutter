import 'package:farmgate/src/common/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: (BuildContext context, LoadStatus mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.arrow_downward, size: 28.0, color: Colors.black),
            SizedBox(height: 6),
            Text(
              'pull_up_load'.tr,
              style: titleBar.copyWith(color: Colors.black),
            ),
          ],
        );
      } else if (mode == LoadStatus.loading) {
        body = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: Colors.black,
              size: 28.0,
            ),
            SizedBox(height: 6),
            Text(
              'loading'.tr,
              style: titleBar.copyWith(color: Colors.black),
            ),
          ],
        );
      } else if (mode == LoadStatus.canLoading) {
        body = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.arrow_downward, size: 28.0, color: Colors.black),
            SizedBox(height: 6),
            Text(
              'update'.tr,
              style: titleBar.copyWith(color: Colors.black),
            ),
          ],
        );
      }
      return Container(child: body);
    });
  }
}
