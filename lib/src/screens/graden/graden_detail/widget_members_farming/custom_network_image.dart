import 'dart:io';

import 'package:farmgate/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class CustomNetworkImageOrFileWidget extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final File fileImg;
  const CustomNetworkImageOrFileWidget(
      {Key key, this.width, this.height, this.url, this.fileImg})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (fileImg != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(width),
          child: Image.file(
            fileImg,
            height: height,
            width: width,
            fit: BoxFit.cover,
          ));
    }
    return CachedNetworkImage(
      imageUrl: url,
      memCacheWidth: 250,
      imageBuilder: (context, img) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: img, fit: BoxFit.cover),
            borderRadius: BorderRadius.all(
              Radius.circular(width / 2),
            ),
          ),
        );
      },
      errorWidget: (
        context,
        url,
        error,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: redColor),
            SizedBox(height: 2.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'image_error'.tr,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        );
      },
      placeholder: (context, string) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(width / 2),
              ),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
