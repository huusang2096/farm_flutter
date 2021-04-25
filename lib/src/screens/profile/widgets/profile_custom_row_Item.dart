import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class CustomRowItemBodyProfile extends StatelessWidget {
  final String image;
  final String title;
  final String decription;
  //0: .svg  or 1: .png
  final bool isPng;
  final Function press;

  const CustomRowItemBodyProfile(
      {Key key,
      this.image,
      this.title,
      this.isPng,
      this.press,
      this.decription})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 14.0,
          ),
          child: Row(
            children: [
              isPng
                  ? Image.asset(
                      image,
                      color: appIconColor,
                    )
                  : SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        image,
                        color: appIconColor,
                      ),
                    ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.tr,
                      style: textInput,
                    ),
                    decription.isEmpty
                        ? SizedBox.shrink()
                        : SizedBox(height: 4),
                    decription.isEmpty
                        ? SizedBox.shrink()
                        : Text(
                            decription.tr,
                            style: timeNews.copyWith(color: Colors.grey),
                          ),
                  ],
                ),
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
