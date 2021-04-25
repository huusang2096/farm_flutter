import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/model/graden/tree_types.dart';
import 'package:farmgate/src/screens/graden/tree/bloc/tree_cubit.dart';
import 'package:farmgate/src/screens/graden/tree/widget/tree_item_form_field_widget.dart';
import 'package:farmgate/src/screens/shimmer/tree_products_shimmer.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:simplest/simplest.dart';

class TreeWidget extends StatelessWidget {
  int gardenId;
  TreeTypes treeTypes;
  TreeWidget(this.treeTypes, this.gardenId);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // News by category
    List<TreeList> listTrees = treeTypes.listTree;
    // final cubit = context.watch<TreeCubit>();
    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      context.read<TreeCubit>().getListTree(treeTypes);
      _refreshController.refreshCompleted();
    }

    int row = 2;
    if (Device.get().isTablet) {
      row = 4;
    }
    return SmartRefresher(
      controller: _refreshController,
      header: ReloadWidget(),
      enablePullDown: true,
      onRefresh: _onRefresh,
      child: Container(
        padding: EdgeInsets.all(10),
        color: backgroundColor,
        child: SingleChildScrollView(
            child: listTrees.length == 0
                ? TreeProductsShimmer()
                : GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: listTrees.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: row,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 0.9),
                    itemBuilder: (context, index) {
                      TreeList tree = listTrees.elementAt(index);
                      bool isShowLoading =
                          context.read<TreeCubit>().state.data.isLoading;
                      bool isIdSelect =
                          context.read<TreeCubit>().state.data.idSelect ==
                              tree.id;
                      return Card(
                        elevation: 5.0,
                        color: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 4.0,
                                  right: 4.0,
                                  left: 4.0,
                                ),
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            tree?.image ?? ""),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 8.0, bottom: 8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${tree?.name ?? ''}',
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      style: titleNew.copyWith(fontSize: 16),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //showmodalbottomsheet formfield
//                                      _showModalBottomSheet(
//                                          tree, context, gardenId);
                                      _showModalBottomSheet(
                                          tree, context, gardenId);
                                      // cubit.addTreeGarden(gardenId, tree.id);
                                    },
                                    child: (isShowLoading && isIdSelect)
                                        ? SpinKitCircle(
                                            color: appIconColor,
                                            size: 40.0,
                                          )
                                        : Icon(
                                            Icons.add_circle_rounded,
                                            color: appIconColor,
                                            size: 40,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }

  _showModalBottomSheet(TreeList tree, BuildContext context, int gardenId) {
    final cubit = context.read<TreeCubit>();
    showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return StatefulBuilder(
            builder: (BuildContext context, state) {
              return AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 10),
                curve: Curves.decelerate,
                child: TreeItemFormFieldWidget(
                  treeList: tree,
                  gardenId: gardenId,
                  onSave: (gardenId, treeId, amount, seeding, plantMethod, year,
                          area, owner, statusGarden) =>
                      cubit.addTreeGarden(
                          id: gardenId,
                          treeID: treeId,
                          area: area,
                          amount: amount,
                          statusGarden: statusGarden,
                          owner: owner,
                          year: year,
                          plantingMethod: plantMethod,
                          seeding: seeding),
                ),
              );
            },
          );
        });
  }
}
