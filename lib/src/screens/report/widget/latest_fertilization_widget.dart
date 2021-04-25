import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class LatestFertilizationWidget extends StatelessWidget {
  final String title;
  final double height;
  final String iconLeft;
  final String date;
  const LatestFertilizationWidget(
      {Key key, this.title, this.height, this.iconLeft, this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: titleNew.copyWith(
                        color: latestFertilizationTitleColor, fontSize: 14.0)),
              ),
              SizedBox(
                width: 20.0,
                height: 20.0,
                child: SvgPicture.asset(
                  iconLeft,
                  color: latestFertilizationTitleColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateTime.tryParse(date) != null
                    ? fullDateFormatter.format(DateTime.parse(date))
                    : date,
                //  date,
                style: textReport.copyWith(
                    fontSize: 14, color: latestFertilizationTextColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
