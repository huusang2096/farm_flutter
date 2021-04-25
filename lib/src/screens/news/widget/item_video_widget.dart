import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/widgets/video_url_widget.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:simplest/simplest.dart';

import '../../../../routes.dart';

// ignore: must_be_immutable
class ItemVideoWidget extends StatelessWidget {
  String herotag;
  News news;
  Category category;

  ItemVideoWidget({Key key, this.herotag, this.news, this.category})
      : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        navigator.pushNamed(AppRoute.newDetailScreen, arguments: {
          'heroTag': herotag,
          'urlImg': news.image,
          'titleAppbar': news.slug,
          'category': category
        });
      },
      child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news.name, textAlign: TextAlign.left, style: titleNew),
              SizedBox(height: 4),
              Container(
                height: MediaQuery.of(context).size.width * (9 / 16),
                child: VideoURLWidget(
                  url: news.videoLink,
                ),
              ),
              SizedBox(height: 6),
              Text(news.description,
                  textAlign: TextAlign.left,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: descNew),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(time(news.createdAt),
                          textAlign: TextAlign.left,
                          style: descNew.copyWith(color: Colors.grey)),
                      InkWell(
                          onTap: () {
                            navigator.pushNamed(AppRoute.commentScreen,
                                arguments: {
                                  'titleAppbar': news.slug,
                                  'title': news.name
                                });
                          },
                          child: Icon(
                            Icons.comment,
                            color: Colors.grey,
                            size: 20,
                          )),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Share.share(news.videoLink);
                    },
                    child: SvgPicture.asset(
                      'assets/images/share_post.svg',
                      width: 20,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Divider(color: Colors.grey.withOpacity(0.5)),
            ],
          )),
    );
  }
}
