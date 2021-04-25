import 'package:farmgate/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class MemberFarmingShimmer extends StatelessWidget {
  final double width;
  final double height;

  const MemberFarmingShimmer({Key key, this.width, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(width / 2),
                ),
                color: whiteColor),
          ),
        ),
        Expanded(
          child: Container(
            width: width,
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  color: whiteColor,
                  child: Text(
                    'add'.tr,
                    style: textBoldBlack.copyWith(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
