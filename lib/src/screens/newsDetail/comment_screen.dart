import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/newsDetail/bloc/detail_cubit.dart';
import 'package:farmgate/src/screens/shimmer/comment_simmer.dart';
import 'package:farmgate/src/widgets/comment_facebook_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'bloc/detail_state.dart';

class CommentScreen extends CubitWidget<DetailCubit, DetailState> {
  final String titleAppbar;
  final String title;

  CommentScreen({this.titleAppbar, this.title});

  static provider({String titleAppbar, String title}) {
    return BlocProvider(
        create: (context) => DetailCubit(),
        child: CommentScreen(
          titleAppbar: titleAppbar,
          title: title,
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    context.read<DetailCubit>().getCommentFacebook(titleAppbar);
  }

  @override
  Widget builder(BuildContext context, DetailState state) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: greyColor),
        elevation: 1,
        centerTitle: true,
        title: Text(title, style: textInput),
      ),
      body: buildBody(size, state, context),
    );
  }

  Widget buildBody(Size size, DetailState state, BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: state.data.postComment != null
            ? CommentFaceWidget(
                url: state.data.postComment.data.url,
                appkey: state.data.postComment.data.appKey,
              )
            : CommentShimmer());
  }
}
