import 'package:dotted_border/dotted_border.dart';
import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/tree_item_widget.dart';
import 'package:farmgate/src/screens/shimmer/tree_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ListTreeWidget extends StatelessWidget {
  final int gardenId;
  ListTreeWidget(this.gardenId);

  @override
  Widget build(BuildContext context) {
    return _buildCategories(context: context);
  }

  Widget _buildCategories({BuildContext context}) {
    final state = context.watch<GardenDetailCubit>().state;
    return Container(
      height: 260,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  "tree".tr,
                  style: titleNew,
                ),
              ]),
              GestureDetector(
                onTap: () {
                  navigator.pushNamed(AppRoute.treeShowAllScreen, arguments: {
                    'treeList': state.data.detail.gardenDetail.treeList,
                    'idGarden': state.data.detail.gardenDetail.id
                  }).then((value) => {
                        context
                            .read<GardenDetailCubit>()
                            .getGardenDetail(state.data.detail.gardenDetail.id)
                      });
                },
                child: Row(
                  children: [
                    Text(
                      'view_all'.tr,
                      style: TextStyle(color: appIconColor),
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: appIconColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          state.data.detail != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount:
                        state.data.detail.gardenDetail.treeList.length > 5
                            ? 5
                            : state.data.detail.gardenDetail.treeList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      double _marginLeft = 0;
                      (index == 0) ? _marginLeft = 0 : _marginLeft = 10;
                      return index == 0
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoute.treeScreen, arguments: {
                                  'gardenId': gardenId
                                }).then((value) => {
                                          context
                                              .read<GardenDetailCubit>()
                                              .getGardenDetail(gardenId)
                                        });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Container(
                                  width: 160,
                                  height: 95,
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(12),
                                    color: Colors.grey,
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                          size: 60,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : TreeItemWidget(
                              marginLeft: _marginLeft,
                              tree: state.data.detail.gardenDetail.treeList
                                  .elementAt(index),
                            );
                    },
                  ),
                )
              : Expanded(child: TreeShimmer(91, 161)),
        ],
      ),
    );
  }
}
