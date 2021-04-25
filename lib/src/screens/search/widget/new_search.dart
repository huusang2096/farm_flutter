import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/screens/news/widget/item_gallery_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_video_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_widget.dart';
import 'package:farmgate/src/screens/search/bloc/search_cubit.dart';
import 'package:farmgate/src/screens/shimmer/news_simmer.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class NewSearchWidget extends StatelessWidget {
  NewSearchWidget();

  @override
  Widget build(BuildContext context) {
    // Hots news

    List<News> hosts = context.watch<SearchCubit>().state.data.news;

    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: hosts.length == 0
            ? NewsShimmer()
            : Column(
                children: [
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: hosts.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 4);
                    },
                    itemBuilder: (context, index) {
                      News news = hosts.elementAt(index);
                      if (news.formatType == null) {
                        return ItemWidget(
                            herotag: getRandomString(20), news: news);
                      } else if (news.formatType == 'video') {
                        return ItemVideoWidget(
                            herotag: getRandomString(20), news: news);
                      } else if (news.formatType == 'gallery') {
                        return ItemGalleryWidget(
                            herotag: getRandomString(20), news: news);
                      }
                    },
                  ),
                ],
              ));
  }
}
