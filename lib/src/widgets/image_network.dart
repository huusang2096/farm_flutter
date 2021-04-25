import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ImageNetWork extends StatelessWidget {
  double width;
  double height;
  String imgUrl;
  double borderRadius;

  ImageNetWork({this.height, this.borderRadius, this.width, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      memCacheWidth: 500,
      imageBuilder: (context, img) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              image: DecorationImage(
                image: img,
                fit: BoxFit.cover,
              )),
        );
      },
      errorWidget: (context, url, error) {
        return Container(child: Center(child: Text('image_error'.tr)));
      },
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
