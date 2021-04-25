import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/screens/news/bloc/news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class CategoriesItemWidget extends StatelessWidget {
  int index = 0;
  Category category;
  CategoriesItemWidget({Key key, this.index, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            context.read<NewsCubit>().changeIndex(index);
            Navigator.of(context).pop();
          },
          child: Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/newspaper.svg',
                    width: 20,
                    height: 20,
                    color: greyColor,
                  ),
                ),
                SizedBox(width: 2.0),
                Expanded(
                  child: Text(
                    category.name.tr,
                    style: titleNew.copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right, color: greyColor),
                SizedBox(width: 10.0),
              ],
            ),
          )),
    );
  }
}
