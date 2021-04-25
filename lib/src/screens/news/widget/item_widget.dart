import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class ItemWidget extends StatelessWidget {
  String herotag;
  News news;
  Category category;
  ItemWidget({Key key, this.herotag, this.news, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fullNameAuthor = news.author?.fullName() ?? '';
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
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2),
                Text(news.name, textAlign: TextAlign.left, style: titleNew),
                SizedBox(height: 8),
                Hero(
                  tag: herotag,
                  child: ImageNetWork(
                      width: double.infinity,
                      height: 250,
                      borderRadius: 0.0,
                      imgUrl: news.image ?? ''),
                ),
                SizedBox(height: 8),
                Text(news.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: descNew),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(time(news.createdAt),
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
                SizedBox(height: 2),
              ],
            )),
      ),
    );
  }
}
