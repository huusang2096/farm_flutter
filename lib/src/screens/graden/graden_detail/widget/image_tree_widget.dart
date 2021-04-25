import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/image_item_widget.dart';
import 'package:farmgate/src/screens/shimmer/tree_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ImageTreeWidget extends StatelessWidget {
  final Function(String) imageSelect;

  const ImageTreeWidget({Key key, this.imageSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCategories(context: context);
  }

  Widget _buildCategories({BuildContext context}) {
    final state = context.watch<GardenDetailCubit>().state;
    return Container(
      height: 180,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'image_tree'.tr,
            style: titleNew,
          ),
          SizedBox(height: 10),
          state.data.detail != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: state.data.detail.gardenDetail.image.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      double _marginLeft = 0;
                      (index == 0) ? _marginLeft = 0 : _marginLeft = 10;
                      return ImageItemWidget(
                        marginLeft: _marginLeft,
                        image: state.data.detail.gardenDetail.image
                            .elementAt(index),
                        imageSelect: (url) {
                          imageSelect(url);
                        },
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
