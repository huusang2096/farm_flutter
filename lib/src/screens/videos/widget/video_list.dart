import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/screens/shimmer/videos_simmer.dart';
import 'package:farmgate/src/screens/videos/bloc/video_cubit.dart';
import 'package:farmgate/src/widgets/video_url_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:simplest/simplest.dart';

/// Creates list of video players
class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<News> videos = context.watch<VideoCubit>().state.data.listVideos;

    return videos.length == 0
        ? VideosShimmer()
        : ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              News video = videos.elementAt(index);
              return InkWell(
                splashColor: Theme.of(context).accentColor.withOpacity(0.08),
                highlightColor: Colors.transparent,
                onTap: () {
                  navigator.pushNamed(AppRoute.newDetailScreen, arguments: {
                    'heroTag': getRandomString(20),
                    'urlImg': video.image,
                    'titleAppbar': video.slug,
                    'isVideo': true
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(video.name,
                            textAlign: TextAlign.left, style: titleNew),
                        SizedBox(height: 4),
                        Container(
                          height: MediaQuery.of(context).size.width * (9 / 16),
                          child: VideoURLWidget(
                            url: video.videoLink,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(video.description,
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
                                Text(time(video.createdAt),
                                    textAlign: TextAlign.left,
                                    style:
                                        descNew.copyWith(color: Colors.grey)),
                                InkWell(
                                    onTap: () {
                                      navigator.pushNamed(
                                          AppRoute.commentScreen,
                                          arguments: {
                                            'titleAppbar': video.slug,
                                            'title': video.name
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
                                Share.share(video.videoLink);
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
            },
            itemCount: videos.length,
            separatorBuilder: (context, _) => const SizedBox(height: 1.0),
          );
  }
}
