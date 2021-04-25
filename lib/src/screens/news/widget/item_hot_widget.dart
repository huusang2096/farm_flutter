import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class ItemHotWidget extends StatefulWidget {
  News news;
  ItemHotWidget({Key key, this.news}) : super(key: key);
  @override
  _ItemHotWidgetState createState() => _ItemHotWidgetState();
}

class _ItemHotWidgetState extends State<ItemHotWidget> {
  @override
  Widget build(BuildContext context) {
    String heroTag = getRandomString(20);
    final _fullNameAuthor = widget.news.author?.fullName() ?? '';
    return InkWell(
        onTap: () {
          navigator.pushNamed(AppRoute.newDetailScreen, arguments: {
            'heroTag': heroTag,
            'urlImg': widget.news.image,
            'titleAppbar': widget.news.slug,
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: heroTag,
              child: ImageNetWork(
                  width: double.infinity,
                  height: 250,
                  borderRadius: 0.0,
                  imgUrl: widget.news.image ?? ''),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.news.name,
                      textAlign: TextAlign.left,
                      style: titleNew.copyWith(
                          color: beginGradientColor, fontSize: 20)),
                  SizedBox(height: 4),
                  Text(widget.news.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: descNew),
                  SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(time(widget.news.createdAt),
                          textAlign: TextAlign.left,
                          style: descNew.copyWith(color: Colors.grey)),
                      SizedBox(width: 4),
                      _fullNameAuthor.isNotEmpty
                          ? Text(_fullNameAuthor,
                              textAlign: TextAlign.left,
                              style: descNew.copyWith(color: Colors.grey))
                          : SizedBox(
                              height: 0.0,
                            ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Divider(color: Colors.grey.withOpacity(0.5)),
                ],
              ),
            )
          ],
        ));
  }
}
