import 'package:dotted_border/dotted_border.dart';
import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/screens/graden/tree/bloc/tree_cubit.dart';
import 'package:farmgate/src/screens/graden/tree/bloc/tree_state.dart';
import 'package:farmgate/src/screens/shimmer/tree_products_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:simplest/simplest.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/tree_item_bottom_sheet_widget.dart';

class TreeShowAllScreen extends CubitWidget<TreeCubit, TreeState> {
  final List<TreeListGarden> treeList;
  final int gardenId;

  TreeShowAllScreen({this.treeList, this.gardenId});

  static provider(
      {List<TreeListGarden> treeList, String heroTag, int gardenId}) {
    return BlocProvider(
      create: (context) => TreeCubit(),
      child: TreeShowAllScreen(
        treeList: treeList,
        gardenId: gardenId,
      ),
    );
  }

  @override
  Widget builder(BuildContext context, TreeState state) {
    int row = 2;
    if (Device.get().isTablet) {
      row = 4;
    }
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        color: backgroundColor,
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: treeList.length == 0
                ? TreeProductsShimmer()
                : GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: treeList.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: row,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 0.95),
                    itemBuilder: (context, index) {
                      TreeListGarden tree = treeList.elementAt(index);
                      return index == 0
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoute.treeScreen,
                                    arguments: {'gardenId': gardenId});
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
                          : GestureDetector(
                              onTap: () {
                                _showModalBottomSheet(tree, context);
                              },
                              child: Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Container(
                                  height: 100.0,
                                  width: 160,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 4.0, right: 4.0, left: 4.0),
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          tree.tree.image ??
                                                              ""),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${tree?.tree.name ?? ''}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: titleNew.copyWith(
                                                        fontSize: 14.0),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  size: 20.0,
                                                  color: beginGradientColor,
                                                ),
                                              ],
                                            ),
                                            height: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  )),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: greyColor),
      title: Text('tree'.tr, style: headingBlack18),
      centerTitle: true,
    );
  }

  _showModalBottomSheet(TreeListGarden tree, BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 10),
                curve: Curves.decelerate,
                child: TreeItemShowModalBottomSheetWidget(
                  treeList: tree,
                ),
              );
            },
          );
        });
  }
}
