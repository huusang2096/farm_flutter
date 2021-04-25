import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:simplest/simplest.dart';

class ItemListSaleWidget extends StatelessWidget {
  final Size size;
  final String titleText, information, description, urlImg;
  final Function onPress;
  final String heroTag;
  const ItemListSaleWidget(
      {Key key,
      this.size,
      this.titleText,
      this.information,
      this.description,
      this.urlImg,
      this.onPress,
      this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: heroTag,
                child: buildCachedNetworkImageWidget(
                    height: size.height * 0.3,
                    width: size.width,
                    imgUrl: urlImg,
                    isBorderRadius: true),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleText,
                      ),
                      SizedBox(height: 4.0),
                      Text(information),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'information'.tr,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCachedNetworkImageWidget(
    {double width, height, String imgUrl, bool isBorderRadius}) {
  return CachedNetworkImage(
    width: width,
    height: height,
    imageUrl: imgUrl ?? '',
    fit: BoxFit.cover,
    memCacheWidth: 500,
    imageBuilder: (context, img) {
      return Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(isBorderRadius ? 8.0 : 0.0)),
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
