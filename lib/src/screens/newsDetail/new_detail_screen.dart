import 'dart:io';

import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/screens/news/widget/item_gallery_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_video_widget.dart';
import 'package:farmgate/src/screens/news/widget/item_widget.dart';
import 'package:farmgate/src/screens/newsDetail/bloc/detail_cubit.dart';
import 'package:farmgate/src/screens/newsDetail/widget/item_list_sale_widget.dart';
import 'package:farmgate/src/screens/shimmer/detail_simmer.dart';
import 'package:farmgate/src/screens/shimmer/detail_title_simmer.dart';
import 'package:farmgate/src/widgets/comment_facebook_widget.dart';
import 'package:farmgate/src/widgets/video_url_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';
import 'package:simplest/simplest.dart';

import 'bloc/detail_state.dart';

class NewDetailScreen extends CubitWidget<DetailCubit, DetailState> {
  final String titleAppbar;
  final String urlImg;
  final String heroTag;
  final Category category;
  final bool isVideo;
  final int NUMBER_OF_COMMENTS = 5;

  NewDetailScreen(
      {this.titleAppbar,
      this.urlImg,
      this.heroTag,
      this.category,
      this.isVideo});

  static provider(
      {String titleAppbar,
      String urlImg,
      String heroTag,
      Category category,
      bool isVideo}) {
    return BlocProvider(
        create: (context) => DetailCubit(),
        child: NewDetailScreen(
          heroTag: heroTag,
          urlImg: urlImg,
          titleAppbar: titleAppbar,
          category: category,
          isVideo: isVideo ?? false,
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<DetailCubit>().getCommentFacebook(titleAppbar);
    context.read<DetailCubit>().getDetail(titleAppbar);
    context.read<DetailCubit>().getNews(category, titleAppbar, isVideo);
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, DetailState state) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: appIconColor,
              ),
            ],
          ),
          width: double.infinity,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                      Platform.isAndroid
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios,
                      color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              Row(
                children: [
                  IconButton(
                    iconSize: 25.0,
                    icon: Icon(Icons.comment, color: Colors.grey),
                    onPressed: () {
                      _showCommentFacebook(
                          state.data.postComment.data.url,
                          state.data.postComment.data.appKey,
                          state.data.detail.data.name,
                          context);
                    },
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    iconSize: 25.0,
                    icon: SvgPicture.asset(
                      'assets/images/share_post.svg',
                      width: 25,
                      height: 25,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Share.share(state.data.postComment.data.url);
                    },
                  ),
                  SizedBox(width: 10),
                ],
              )
            ],
          )),
      body: buildBody(size, state, context),
    );
  }

  Widget buildBody(Size size, DetailState state, BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kToolbarHeight / 2),
          state.data.detail == null
              ? DetailTileShimmer()
              : buildTitle(
                  participationTime: state.data.detail.data.createdAt,
                  titleSale: state.data.detail.data.name,
                  category: state.data.detail?.data?.categories[0].name),
          //img
          (state.data.detail != null &&
                  state.data.detail.data.videoLink != null)
              ? Container(
                  height: MediaQuery.of(context).size.width * (9 / 16),
                  child: VideoURLWidget(
                    url: state.data.detail.data.videoLink,
                  ),
                )
              : Hero(
                  tag: heroTag,
                  child: buildCachedNetworkImageWidget(
                      isBorderRadius: false,
                      imgUrl: urlImg,
                      width: size.width,
                      height: size.height * 0.4),
                ),

          state.data.detail == null
              ? DetailShimmer()
              : buildInformationSale(
                  attention: state.data.detail.data.description,
                  information: state.data.detail.data.content),
          state.data.detail == null
              ? SizedBox.shrink()
              : buildResource(
                  resource: state.data.detail.data.resource, author: ''),
          SizedBox(height: 8),
          Container(height: 3, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('news_other'.tr, style: descNew),
          ),
          state.data.news.length == 0
              ? SizedBox.shrink()
              : ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount:
                      state.data.news.length >= 5 ? 5 : state.data.news.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 4);
                  },
                  itemBuilder: (context, index) {
                    News news = state.data.news.elementAt(index);
                    if (news.formatType == null) {
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
                )
        ],
      ),
    );
  }

  Widget _showCommentFacebook(
      String url, String appKey, String title, BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (BuildContext builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.decelerate,
                  child: SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(height: kToolbarHeight / 2),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Platform.isAndroid
                                      ? Icons.arrow_back
                                      : Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: greyColor,
                                ),
                                Expanded(
                                  child: Text(title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: descNew),
                                ),
                                Container(width: 10),
                              ],
                            ),
                            Container(height: 1, color: Colors.grey[300]),
                            Expanded(
                              child: CommentFaceWidget(
                                url: url,
                                appkey: appKey,
                              ),
                            ),
                          ],
                        )),
                  ));
            },
          );
        });
  }

  Widget buildInformationSale({String information, attention}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Html(
        data: information ?? '',
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildResource({String resource, String author}) {
    return resource == null
        ? SizedBox.shrink()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('resource'.tr, style: textInput),
                GestureDetector(
                  onTap: () {
                    _launchURL(resource);
                  },
                  child: Text(resource,
                      maxLines: 2,
                      style: textInput.copyWith(color: Colors.blue)),
                )
              ],
            ),
          );
  }

  Widget buildTitle({String titleSale, participationTime, String category}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: timeNews.copyWith(color: appIconColor)),
          SizedBox(height: 4),
          Row(
            children: [
              Text(fullDateFormatter.format(DateTime.parse(participationTime)),
                  textAlign: TextAlign.left,
                  style: timeNews.copyWith(color: Colors.grey)),
              Text(','),
              Text(hourFormatter.format(DateTime.parse(participationTime)),
                  textAlign: TextAlign.left,
                  style: timeNews.copyWith(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 8),
          Text(titleSale, style: titleNew),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
