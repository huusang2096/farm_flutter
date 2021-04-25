import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/screens/graden/tree/bloc/tree_cubit.dart';
import 'package:farmgate/src/screens/graden/tree/bloc/tree_state.dart';
import 'package:farmgate/src/screens/shimmer/tree_products_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:simplest/simplest.dart';

class TreeShowAllAndPickTree extends CubitWidget<TreeCubit, TreeState> {
  static provider({int idGarden}) {
    return BlocProvider(
      create: (context) => TreeCubit(idGarden: idGarden),
      child: TreeShowAllAndPickTree(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context
        .read<TreeCubit>()
        .getListTreeById(context.read<TreeCubit>().state.data.idGarden);
    super.afterFirstLayout(context);
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
            child: state.data.listTree == null
                ? TreeProductsShimmer()
                : state.data.listTree.isEmpty
                    ? Container(
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'please_add_plants_to_your_garden_before_fertilizing'
                                  .tr,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.data.listTree.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: row,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 0.95),
                        itemBuilder: (context, index) {
                          TreeList tree = state.data.listTree.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              navigator.pop({'tree': tree});
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        tree.image ?? ""),
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
                                        height: 30,
                                        child: Text(
                                          '${tree?.name ?? ''}',
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style:
                                              titleNew.copyWith(fontSize: 14.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
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
      elevation: 1.0,
      centerTitle: true,
    );
  }
}
