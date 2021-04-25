import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/tree_item_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class TreeItemWidget extends StatelessWidget {
  final TreeListGarden tree;
  final double marginLeft;
  const TreeItemWidget({Key key, this.tree, this.marginLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModalBottomSheet(tree, context);
      },
      child: Container(
        margin: EdgeInsets.only(left: marginLeft),
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
                    padding: EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                tree.tree?.image ?? ""),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${tree?.tree?.name ?? ''}',
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: titleNew.copyWith(fontSize: 14.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 20.0,
                          color: appIconColor,
                        ),
                      ],
                    ),
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                child: TreeItemShowModalBottomSheetWidget(treeList: tree),
              );
            },
          );
        });
  }
}
