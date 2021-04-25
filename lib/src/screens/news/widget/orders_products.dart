import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/screens/news/bloc/news_cubit.dart';
import 'package:farmgate/src/screens/news/widget/item_gallery_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_hot_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_video_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_widget.dart';
import 'package:farmgate/src/screens/shimmer/news_simmer.dart';
import 'package:farmgate/src/widgets/empty_news_widget.dart';
import 'package:farmgate/src/widgets/footer_widget.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class OrdersProductsWidget extends StatelessWidget {
  Category category;
  OrdersProductsWidget(this.category);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // Hots news
    List<News> host = [];
    if (category.id == 0) {
      host = context.watch<NewsCubit>().state.data.hotNews;
    } else {
      host = context
          .watch<NewsCubit>()
          .state
          .data
          .hotNews
          .where((data) => data.id == category.id)
          .toList();
    }

    // News by category
    List<News> listNews = category.listNews;
    bool isLoading = context.watch<NewsCubit>().state.data.isLoading &&
        context.watch<NewsCubit>().state.data.isCategory == category.id &&
        listNews.length == 0;

    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      context.read<NewsCubit>().getNews(category);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      context.read<NewsCubit>().getMore(category);
      _refreshController.loadComplete();
    }

    return SmartRefresher(
      controller: _refreshController,
      header: ReloadWidget(),
      footer: FooterWidget(),
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Container(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: isLoading
                ? NewsShimmer()
                : (listNews.length == 0
                    ? EmptyNewWidget()
                    : Column(
                        children: [
                          host.length != 0
                              ? ItemHotWidget(news: host[0])
                              : SizedBox.shrink(),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            primary: false,
                            itemCount: listNews.length,
                            itemBuilder: (context, index) {
                              News news = listNews.elementAt(index);
                              if (host.length == 0 && index == 0) {
                                return ItemHotWidget(news: news);
                              } else if (news.formatType == null) {
                                return ItemWidget(
                                    herotag: getRandomString(20),
                                    news: news,
                                    category: category);
                              } else if (news.formatType == 'video') {
                                return ItemVideoWidget(
                                    herotag: getRandomString(20),
                                    news: news,
                                    category: category);
                              } else if (news.formatType == 'gallery') {
                                return ItemGalleryWidget(
                                    herotag: getRandomString(20),
                                    news: news,
                                    category: category);
                              }
                            },
                          ),
                        ],
                      ))),
      ),
    );
  }
}
