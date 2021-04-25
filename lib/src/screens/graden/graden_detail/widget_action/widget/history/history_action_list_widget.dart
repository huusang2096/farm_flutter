import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'history_action_item_widget.dart';

class HistoryActionListWidget extends StatefulWidget {
  ActionModel actionModel;
  String image;
  int index = 0;
  HistoryActionListWidget(this.actionModel, this.index, this.image);

  @override
  _HistoryActionListWidgetState createState() =>
      _HistoryActionListWidgetState();
}

class _HistoryActionListWidgetState extends State<HistoryActionListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                child: Container(
              width: 30.0,
              height: 30.0,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: linearGradient,
                borderRadius: BorderRadius.circular(60.0),
              ),
              child: Text(
                widget.index.toString(),
                textAlign: TextAlign.center,
                style: titleBar,
              ),
            )),
            SizedBox(width: 10),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: widget.actionModel.unitName.tr + ": ",
                      style: body1.copyWith(color: Colors.black)),
                  TextSpan(
                      text: '*', style: body1.copyWith(color: Colors.redAccent))
                ]),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              FDottedLine(
                color: appIconColor,
                height: widget.actionModel.inputProduct.length * 50.0,
              ),
              SizedBox(width: 26),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  addAutomaticKeepAlives: true,
                  itemCount: widget.actionModel.inputProduct.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.5),
                  itemBuilder: (context, index) {
                    InputProduct actiontype =
                        widget.actionModel.inputProduct.elementAt(index);
                    return HistoryActionItemWidget(
                      actionType: actiontype,
                      type: widget.image,
                      onSelectActionType: (actionType) {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
