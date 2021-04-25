import 'package:farmgate/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class TotalPostWidget extends StatelessWidget {
  final int totalPosts;
  final double height;

  const TotalPostWidget({Key key, this.totalPosts, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: totalPostColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'total_post'.tr,
                  style: titleNew.copyWith(color: Colors.white),
                ),
              ),
              Icon(
                Icons.description,
                color: totalPostTextColor,
                size: 40,
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(totalPosts.toString(),
                    style: textReport.copyWith(color: totalPostTextColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
