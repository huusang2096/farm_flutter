import 'package:farmgate/src/common/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ReloadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      failedIcon: Icon(Icons.error, color: Colors.black),
      completeIcon: Icon(Icons.done, color: Colors.black),
      idleIcon: Icon(Icons.arrow_downward, color: Colors.black),
      releaseIcon: Icon(Icons.refresh, color: Colors.black),
      refreshingIcon: SpinKitCircle(
        color: Colors.black,
        size: 28.0,
      ),
      textStyle: titleBar.copyWith(color: Colors.black),
      refreshingText: 'loading'.tr,
      releaseText: 'loading'.tr,
      idleText: 'update'.tr,
      completeText: 'completeText'.tr,
    );
  }
}
