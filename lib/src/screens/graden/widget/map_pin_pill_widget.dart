import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class MapPinPillWidget extends StatelessWidget {
  final double pinPillPosition;
  final MyGarden currentlySelectedPin;

  MapPinPillWidget({this.pinPillPosition, this.currentlySelectedPin});

  @override
  Widget build(BuildContext context) {
    final _avatar = currentlySelectedPin?.image?.first ??
        'https://www.thebloodytourofyork.co.uk/wp-content/uploads/2020/07/placeholder.png';
    return AnimatedPositioned(
      bottom: pinPillPosition,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 500),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 20,
                    offset: Offset.zero,
                    color: Colors.grey.withOpacity(0.5))
              ]),
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
                ),
                child: CachedNetworkImage(
                  imageUrl: _avatar,
                  memCacheWidth: 250,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)),
                    ),
                  ),
                  placeholder: (context, str) =>
                      Images.placeholder.loadImage(size: 200.0),
                  errorWidget: (c, s, erorr) =>
                      Images.placeholder.loadImage(size: 200),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        currentlySelectedPin?.name ?? '',
                        style: titleNew,
                      ),
                      Text(
                        currentlySelectedPin?.description ?? '',
                        style: descNew,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      GestureDetector(
                        onTap: () {
                          navigator.pushNamed(AppRoute.detailGardenScreen,
                              arguments: {
                                'img': _avatar,
                                'id': currentlySelectedPin.id,
                                'heroTag': getRandomString(20),
                                'data': currentlySelectedPin,
                              });
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(80.0),
                              child: Icon(Icons.remove_red_eye,
                                  size: 25, color: appIconColor),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'view_detail'.tr,
                              style: descNew,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
