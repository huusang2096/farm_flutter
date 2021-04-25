import 'package:farmgate/src/common/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class CustomTypeProfile extends StatelessWidget {
  final String image;
  final String title;
  final bool isPng;
  final type;
  final Function press;
  final Function onPressReasonNotApproval;

  const CustomTypeProfile({
    Key key,
    this.image,
    this.title,
    this.isPng,
    this.press,
    this.type,
    this.onPressReasonNotApproval,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.tr,
                    style: titleNew.copyWith(fontSize: 22),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: type == 'draft' ? onPressReasonNotApproval : () {},
                    child: Text(
                      //update approval reason
                      type == "pending"
                          ? 'pending'.tr
                          : type == 'draft'
                              ? 'draft'.tr
                              : 'published'.tr,
                      //if type = published, color is activeGreen and others is red
                      style: titleBar.copyWith(
                          color: type != "published" ? redColor : activeGreen),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_right_sharp,
                color: Colors.grey,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
