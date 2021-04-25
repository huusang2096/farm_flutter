import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/screens/news/bloc/news_cubit.dart';
import 'package:farmgate/src/screens/news/widget/categories_item_widget.dart';
import 'package:farmgate/src/screens/shimmer/category_simmer.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> categorys = context.watch<NewsCubit>().state.data.categorys;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.grey),
        centerTitle: true,
        elevation: 1,
        title: Text(
          'category'.tr,
          style: title.merge(TextStyle(color: Colors.black)),
        ),
        actions: <Widget>[],
      ),
      body: Container(
        color: whiteColor,
        child: Column(
          children: <Widget>[
            categorys.length == 0
                ? CategoryShimmer()
                : Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.0,
                        );
                      },
                      padding: EdgeInsets.only(top: 10.0),
                      itemCount: categorys.length,
                      itemBuilder: (context, index) {
                        return CategoriesItemWidget(
                          index: index,
                          category: categorys.elementAt(index),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
