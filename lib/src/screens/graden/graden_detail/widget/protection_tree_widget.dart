import 'package:dotted_border/dotted_border.dart';
import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/tree_protection_item_widget.dart';
import 'package:farmgate/src/screens/shimmer/tree_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ListProtectionTreeWidget extends StatelessWidget {
  final int gardenId;
  ListProtectionTreeWidget(this.gardenId);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'plant_protection'.tr,
            style: titleNew,
          ),
          SizedBox(height: 10),
          state.data.detail != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: state.data.detail.gardenDetail
                        .gardenPlantProtectionProducts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      double _marginLeft = 0;
                      (index == 0) ? _marginLeft = 0 : _marginLeft = 10;
                      return index == 0
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoute.listPlant, arguments: {
                                  'idGarden': gardenId,
                                  'action_type': state.data.productPlan
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
                          : TreeProtectionItemWidget(
                              marginLeft: _marginLeft,
                              plantProtect: state.data.detail.gardenDetail
                                  .gardenPlantProtectionProducts
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
