import 'package:farmgate/src/widgets/image_network.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageItemWidget extends StatelessWidget {
  final String image;
  final double marginLeft;
  final Function(String) imageSelect;
  const ImageItemWidget(
      {Key key, this.image, this.marginLeft, this.imageSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        imageSelect(image);
      },
      child: Container(
        margin: EdgeInsets.only(left: marginLeft),
        child: ImageNetWork(
            width: 160, height: 100, borderRadius: 8, imgUrl: image),
      ),
    );
  }
}
