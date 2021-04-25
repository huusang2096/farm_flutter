import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class ItemGalleryWidget extends StatelessWidget {
  String herotag;
  Category category;
  News news;

  ItemGalleryWidget({Key key, this.herotag, this.news, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Theme.of(context).accentColor.withOpacity(0.08),
        highlightColor: Colors.transparent,
        onTap: () {
          navigator.pushNamed(AppRoute.newDetailScreen, arguments: {
            'heroTag': "herotag",
            'urlImg': news.image,
            'titleAppbar': news.slug,
            'category': category
          });
        },
        child: Hero(
          tag: herotag,
          child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.name, textAlign: TextAlign.left, style: titleNew),
                  SizedBox(height: 10),
                  Container(
                    height: 84,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        double _marginLeft = 0;
                        (index == 0) ? _marginLeft = 0 : _marginLeft = 10;
                        return Container(
                          margin: EdgeInsets.only(left: _marginLeft),
                          child: ImageNetWork(
                              width: 100,
                              height: 80,
                              borderRadius: 8,
                              imgUrl: news.image),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/calendar.svg',
                        width: 25,
                        height: 25,
                        color: beginGradientColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                          fullDateFormatter
                              .format(DateTime.parse(news.createdAt)),
                          textAlign: TextAlign.left,
                          style: descNew.copyWith(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(height: 1, color: Colors.grey.withOpacity(0.5)),
                ],
              )),
        ));
  }
}
